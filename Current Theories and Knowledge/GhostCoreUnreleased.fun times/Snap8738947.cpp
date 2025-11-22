// PBS Agent.cpp : Defines the entry point for the application.
//
#include "framework.h"
#include "PBS Agent.h"
#include <windows.h>
#include <vss.h>
#include <vswriter.h>
#include <vsbackup.h>
#include <iostream>
#include <atlbase.h>
#include <comdef.h>
#include <string>
#include "PBSClient.h"
#include <openssl/sha.h>
#include <fstream>
#include <iomanip>
#include <nlohmann/json.hpp>
#include <unordered_map>
#include <sstream>

#define MAX_LOADSTRING 100
#define IDM_CREATE_SNAPSHOT 32771
#define IDC_SERVER_URL     1001
#define IDC_USERNAME       1002
#define IDC_PASSWORD       1003
#define IDC_DATASTORE      1004

// Global Variables:
HINSTANCE hInst;                                // current instance
WCHAR szTitle[MAX_LOADSTRING];                  // The title bar text
WCHAR szWindowClass[MAX_LOADSTRING];            // the main window class name

// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

HRESULT InitializeAndCreateVSSSnapshot(const std::string& serverUrl, const std::string& username, const std::string& password, const std::string& datastore);
HRESULT BackupSnapshotData(const std::wstring& snapshotDevice, PBSClient& client);
bool Backup(PBSClient& client, const std::wstring& backupDir);
void TraverseDirectory(const std::wstring& directory, std::vector<std::wstring>& files);
bool ProcessFiles(PBSClient& client, const std::vector<std::wstring>& files, const std::string& archiveId);
void LogDetailedError(const char* message, HRESULT hr);

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
    _In_opt_ HINSTANCE hPrevInstance,
    _In_ LPWSTR    lpCmdLine,
    _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    // Initialize COM library
    HRESULT hr = CoInitializeEx(NULL, COINIT_MULTITHREADED);
    if (FAILED(hr))
    {
        std::cerr << "Failed to initialize COM library. Error: " << std::hex << hr << std::endl;
        return FALSE;
    }

    // Initialize global strings
    LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadStringW(hInstance, IDC_PBSAGENT, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Perform application initialization:
    if (!InitInstance(hInstance, nCmdShow))
    {
        CoUninitialize();
        return FALSE;
    }

    HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_PBSAGENT));

    MSG msg;

    // Main message loop:
    while (GetMessage(&msg, nullptr, 0, 0))
    {
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    CoUninitialize();
    return (int)msg.wParam;
}

//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEXW wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc = WndProc;
    wcex.cbClsExtra = 0;
    wcex.cbWndExtra = 0;
    wcex.hInstance = hInstance;
    wcex.hIcon = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_PBSAGENT));
    wcex.hCursor = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
    wcex.lpszMenuName = MAKEINTRESOURCEW(IDC_PBSAGENT);
    wcex.lpszClassName = szWindowClass;
    wcex.hIconSm = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

    return RegisterClassExW(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
    hInst = hInstance; // Store instance handle in our global variable

    HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
        CW_USEDEFAULT, 0, 400, 300, nullptr, nullptr, hInstance, nullptr);

    if (!hWnd)
    {
        return FALSE;
    }

    // Create labels and input fields for server information
    CreateWindowW(L"STATIC", L"Server URL:", WS_VISIBLE | WS_CHILD,
        10, 10, 100, 20, hWnd, NULL, hInstance, NULL);

    HWND hServerUrl = CreateWindowW(L"EDIT", NULL, WS_VISIBLE | WS_CHILD | WS_BORDER,
        120, 10, 250, 20, hWnd, (HMENU)IDC_SERVER_URL, hInstance, NULL);

    CreateWindowW(L"STATIC", L"Username:", WS_VISIBLE | WS_CHILD,
        10, 40, 100, 20, hWnd, NULL, hInstance, NULL);

    HWND hUsername = CreateWindowW(L"EDIT", NULL, WS_VISIBLE | WS_CHILD | WS_BORDER,
        120, 40, 250, 20, hWnd, (HMENU)IDC_USERNAME, hInstance, NULL);

    CreateWindowW(L"STATIC", L"Password:", WS_VISIBLE | WS_CHILD,
        10, 70, 100, 20, hWnd, NULL, hInstance, NULL);

    HWND hPassword = CreateWindowW(L"EDIT", NULL, WS_VISIBLE | WS_CHILD | WS_BORDER | ES_PASSWORD,
        120, 70, 250, 20, hWnd, (HMENU)IDC_PASSWORD, hInstance, NULL);

    CreateWindowW(L"STATIC", L"Datastore:", WS_VISIBLE | WS_CHILD,
        10, 100, 100, 20, hWnd, NULL, hInstance, NULL);

    HWND hDatastore = CreateWindowW(L"EDIT", NULL, WS_VISIBLE | WS_CHILD | WS_BORDER,
        120, 100, 250, 20, hWnd, (HMENU)IDC_DATASTORE, hInstance, NULL);

    // Add the "Create Snapshot" button
    HWND hButton = CreateWindowW(
        L"BUTTON",  // Predefined class; Unicode assumed 
        L"Create Snapshot",      // Button text 
        WS_TABSTOP | WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,  // Styles 
        10,         // x position 
        140,        // y position 
        150,        // Button width
        30,         // Button height
        hWnd,       // Parent window
        (HMENU)IDM_CREATE_SNAPSHOT,       // Menu ID
        hInstance,
        NULL);      // Pointer not needed

    ShowWindow(hWnd, nCmdShow);
    UpdateWindow(hWnd);

    return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE: Processes messages for the main window.
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
    case WM_COMMAND:
    {
        int wmId = LOWORD(wParam);
        switch (wmId)
        {
        case IDM_CREATE_SNAPSHOT:
        {
            // Retrieve input values
            WCHAR serverUrl[256];
            WCHAR username[256];
            WCHAR password[256];
            WCHAR datastore[256];

            GetWindowTextW(GetDlgItem(hWnd, IDC_SERVER_URL), serverUrl, 256);
            GetWindowTextW(GetDlgItem(hWnd, IDC_USERNAME), username, 256);
            GetWindowTextW(GetDlgItem(hWnd, IDC_PASSWORD), password, 256);
            GetWindowTextW(GetDlgItem(hWnd, IDC_DATASTORE), datastore, 256);

            // Convert WCHAR to std::wstring
            std::wstring wsServerUrl(serverUrl);
            std::wstring wsUsername(username);
            std::wstring wsPassword(password);
            std::wstring wsDatastore(datastore);

            // Convert std::wstring to UTF-8 std::string
            auto WideStringToUTF8 = [](const std::wstring& wstr) -> std::string {
                if (wstr.empty()) return std::string();
                int sizeNeeded = WideCharToMultiByte(CP_UTF8, 0, &wstr[0], (int)wstr.size(), NULL, 0, NULL, NULL);
                std::string strTo(sizeNeeded, 0);
                WideCharToMultiByte(CP_UTF8, 0, &wstr[0], (int)wstr.size(), &strTo[0], sizeNeeded, NULL, NULL);
                return strTo;
                };

            std::string sServerUrl = WideStringToUTF8(wsServerUrl);
            std::string sUsername = WideStringToUTF8(wsUsername);
            std::string sPassword = WideStringToUTF8(wsPassword);
            std::string sDatastore = WideStringToUTF8(wsDatastore);

            // Input validation
            if (sServerUrl.empty() || sUsername.empty() || sPassword.empty() || sDatastore.empty())
            {
                MessageBox(hWnd, L"Please fill in all the fields.", L"Input Error", MB_OK | MB_ICONERROR);
                return 0;
            }

            // Call your VSS function with server information
            HRESULT hr = InitializeAndCreateVSSSnapshot(sServerUrl, sUsername, sPassword, sDatastore);

            if (SUCCEEDED(hr))
            {
                MessageBox(hWnd, L"VSS Snapshot created and backed up successfully!", L"Success", MB_OK);
            }
            else
            {
                // Use detailed error logging here
                wchar_t errorMessage[512];
                _com_error err(hr);
                LPCTSTR errMsg = err.ErrorMessage();
                swprintf_s(errorMessage, 512, L"Failed to create and backup VSS Snapshot. Error code: 0x%08X\nError message: %s", hr, errMsg);
                MessageBox(hWnd, errorMessage, L"Error", MB_OK);
            }
            break;
        }
        case IDM_ABOUT:
            DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
            break;
        case IDM_EXIT:
            DestroyWindow(hWnd);
            break;
        default:
            return DefWindowProc(hWnd, message, wParam, lParam);
        }
    }
    break;
    case WM_PAINT:
    {
        PAINTSTRUCT ps;
        HDC hdc = BeginPaint(hWnd, &ps);
        // TODO: Add any drawing code here...
        EndPaint(hWnd, &ps);
    }
    break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
    switch (message)
    {
    case WM_INITDIALOG:
        return (INT_PTR)TRUE;

    case WM_COMMAND:
        if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (INT_PTR)FALSE;
}

void LogDetailedError(const char* message, HRESULT hr)
{
    _com_error err(hr);
    LPCTSTR errMsg = err.ErrorMessage();
    std::cerr << message << " Error: " << std::hex << hr << " (" << errMsg << ")" << std::endl;
}

HRESULT InitializeAndCreateVSSSnapshot(const std::string& serverUrl, const std::string& username, const std::string& password, const std::string& datastore)
{
    HRESULT hr = S_OK;

    CComPtr<IVssBackupComponents> pBackupComponents;
    hr = CreateVssBackupComponents(&pBackupComponents);
    if (FAILED(hr) || !pBackupComponents)
    {
        LogDetailedError("Failed to create VSS backup components object.", hr);
        return hr;
    }

    hr = pBackupComponents->InitializeForBackup();
    if (FAILED(hr))
    {
        LogDetailedError("Failed to initialize for backup.", hr);
        return hr;
    }

    hr = pBackupComponents->SetBackupState(
        FALSE,          // bSelectComponents: FALSE if you don't want to select components
        FALSE,          // bBackupBootableSystemState: FALSE if not backing up bootable system state
        VSS_BT_FULL,    // BackupType: VSS_BT_FULL for a full backup
        FALSE           // bPartialFileSupport: FALSE if not supporting partial files
    );
    if (FAILED(hr))
    {
        LogDetailedError("Failed to set backup state.", hr);
        return hr;
    }

    hr = pBackupComponents->SetContext(VSS_CTX_BACKUP);
    if (FAILED(hr))
    {
        LogDetailedError("Failed to set context.", hr);
        return hr;
    }

    // Gather writer metadata
    CComPtr<IVssAsync> pAsync;
    hr = pBackupComponents->GatherWriterMetadata(&pAsync);
    if (FAILED(hr) || !pAsync)
    {
        LogDetailedError("Failed to gather writer metadata.", hr);
        return hr;
    }

    hr = pAsync->Wait();
    if (FAILED(hr))
    {
        LogDetailedError("Failed to wait for GatherWriterMetadata completion.", hr);
        return hr;
    }

    // Start the snapshot set
    VSS_ID snapshotSetId = GUID_NULL;
    hr = pBackupComponents->StartSnapshotSet(&snapshotSetId);
    if (FAILED(hr))
    {
        LogDetailedError("Failed to start snapshot set.", hr);
        return hr;
    }

    // Add volume to snapshot set
    VSS_ID snapshotId = GUID_NULL;
    wchar_t volumeName[] = L"C:\\";
    hr = pBackupComponents->AddToSnapshotSet(volumeName, GUID_NULL, &snapshotId);
    if (FAILED(hr))
    {
        LogDetailedError("Failed to add volume to snapshot set.", hr);
        return hr;
    }

    // Prepare for backup
    pAsync.Release(); // Release and reuse pAsync for the next async operation
    hr = pBackupComponents->PrepareForBackup(&pAsync);
    if (FAILED(hr) || !pAsync)
    {
        LogDetailedError("Failed to prepare for backup.", hr);
        return hr;
    }

    // Wait for preparation to complete
    hr = pAsync->Wait();
    if (FAILED(hr))
    {
        LogDetailedError("Failed to wait for PrepareForBackup completion.", hr);
        return hr;
    }

    // Create the snapshot
    pAsync.Release(); // Release and reuse pAsync for the next async operation
    hr = pBackupComponents->DoSnapshotSet(&pAsync);
    if (FAILED(hr) || !pAsync)
    {
        LogDetailedError("Failed to create snapshot.", hr);
        return hr;
    }

    // Wait for snapshot creation to complete
    hr = pAsync->Wait();
    if (FAILED(hr))
    {
        LogDetailedError("Failed to wait for DoSnapshotSet completion.", hr);
        return hr;
    }

    // Get snapshot properties
    VSS_SNAPSHOT_PROP snapshotProp = {};
    hr = pBackupComponents->GetSnapshotProperties(snapshotId, &snapshotProp);
    if (FAILED(hr))
    {
        LogDetailedError("Failed to get snapshot properties.", hr);
        return hr;
    }

    // The snapshot device object is available in snapshotProp.m_pwszSnapshotDeviceObject
    wprintf(L"Snapshot device object: %s\n", snapshotProp.m_pwszSnapshotDeviceObject);

    // Initialize PBSClient with the provided server details
    PBSClient client(
        serverUrl,   // baseurl
        username,    // authid
        password,    // secret
        datastore    // datastore
    );

    // Start the backup process
    hr = BackupSnapshotData(snapshotProp.m_pwszSnapshotDeviceObject, client);
    if (FAILED(hr))
    {
        LogDetailedError("Failed to backup snapshot data.", hr);
        // Clean up snapshot
        LONG deletedSnapshots = 0;
        VSS_ID nonDeletedSnapshots = GUID_NULL;
        pBackupComponents->DeleteSnapshots(snapshotId, VSS_OBJECT_SNAPSHOT, TRUE, &deletedSnapshots, &nonDeletedSnapshots);
        return hr;
    }

    // Clean up snapshot after backup
    LONG deletedSnapshots = 0;
    VSS_ID nonDeletedSnapshots = GUID_NULL;
    hr = pBackupComponents->DeleteSnapshots(snapshotId, VSS_OBJECT_SNAPSHOT, TRUE, &deletedSnapshots, &nonDeletedSnapshots);
    if (FAILED(hr))
    {
        LogDetailedError("Failed to delete snapshot.", hr);
    }

    return S_OK;
}

HRESULT BackupSnapshotData(const std::wstring& snapshotDevice, PBSClient& client)
{
    std::wstring backupDir = snapshotDevice; // The snapshot volume path

    bool success = Backup(client, backupDir); // Implement Backup function

    if (!success)
    {
        std::cerr << "Failed to backup snapshot data.\n";
        return E_FAIL;
    }

    return S_OK;
}

bool Backup(PBSClient& client, const std::wstring& backupDir)
{
    // Connect to PBS
    if (!client.Connect())
    {
        std::cerr << "Failed to connect to PBS.\n";
        return false;
    }

    // Create a dynamic index for the backup
    std::string archiveName = "backup.pxar.didx";
    std::string archiveId = client.CreateDynamicIndex(archiveName);

    // Traverse the backupDir and get list of files
    std::vector<std::wstring> files;
    TraverseDirectory(backupDir, files);

    // Process files
    if (!ProcessFiles(client, files, archiveId))
    {
        std::cerr << "Failed to process files.\n";
        return false;
    }

    // Upload manifest
    if (!client.UploadManifest())
    {
        std::cerr << "Failed to upload manifest.\n";
        return false;
    }

    if (!client.Finish())
    {
        std::cerr << "Failed to finalize backup.\n";
        return false;
    }

    return true;
}

void TraverseDirectory(const std::wstring& directory, std::vector<std::wstring>& files)
{
    WIN32_FIND_DATAW findFileData;
    HANDLE hFind;

    std::wstring searchPath = directory + L"\\*";

    hFind = FindFirstFileW(searchPath.c_str(), &findFileData);

    if (hFind == INVALID_HANDLE_VALUE)
    {
        std::wcerr << L"FindFirstFileW failed for " << directory << L"\n";
        return;
    }

    do
    {
        const std::wstring fileName = findFileData.cFileName;

        if (fileName == L"." || fileName == L"..")
            continue;

        std::wstring fullPath = directory + L"\\" + fileName;

        if (findFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
        {
            // Recursively traverse subdirectories
            TraverseDirectory(fullPath, files);
        }
        else
        {
            // Add file to the list
            files.push_back(fullPath);
        }

    } while (FindNextFileW(hFind, &findFileData) != 0);

    FindClose(hFind);
}

bool ProcessFiles(PBSClient& client, const std::vector<std::wstring>& files, const std::string& archiveId)
{
    const size_t CHUNK_SIZE = 4 * 1024 * 1024; // 4 MB
    std::unordered_map<std::string, bool> knownChunks;

    std::vector<std::string> chunkIds;
    std::vector<uint64_t> offsets;
    uint64_t pos = 0;

    for (const auto& file : files)
    {
        std::ifstream inFile(file, std::ios::binary);
        if (!inFile.is_open())
        {
            std::wcerr << L"Failed to open file: " << file << L"\n";
            continue;
        }

        while (!inFile.eof())
        {
            std::vector<uint8_t> buffer(CHUNK_SIZE);
            inFile.read(reinterpret_cast<char*>(buffer.data()), CHUNK_SIZE);
            std::streamsize bytesRead = inFile.gcount();
            if (bytesRead <= 0)
                break;

            buffer.resize(bytesRead);

            // Compute SHA-256 hash
            unsigned char hash[SHA256_DIGEST_LENGTH];
            SHA256(buffer.data(), buffer.size(), hash);

            // Convert hash to hex string
            std::stringstream ss;
            for (int i = 0; i < SHA256_DIGEST_LENGTH; ++i)
            {
                ss << std::hex << std::setw(2) << std::setfill('0') << (int)hash[i];
            }
            std::string chunkId = ss.str();

            // Check if chunk is known
            if (knownChunks.find(chunkId) == knownChunks.end())
            {
                // Upload chunk
                if (!client.UploadCompressedChunk(archiveId, chunkId, buffer))
                {
                    std::cerr << "Failed to upload chunk.\n";
                    return false;
                }
                knownChunks[chunkId] = true;
            }

            // Add to assignments
            chunkIds.push_back(chunkId);
            offsets.push_back(pos);
            pos += buffer.size();
        }

        inFile.close();
    }

    // Assign chunks
    if (!client.AssignChunks(archiveId, chunkIds, offsets))
    {
        std::cerr << "Failed to assign chunks.\n";
        return false;
    }

    // Compute digest (placeholder)
    std::string digest = "digest-placeholder";

    // Close dynamic index
    if (!client.CloseDynamicIndex(archiveId, digest, pos, chunkIds.size()))
    {
        std::cerr << "Failed to close dynamic index.\n";
        return false;
    }

    return true;
}
