#include <Windows.h>
#include <iostream>

void selection_sort(int A[], int n)
{
    int i, j, x, min;
    for (i = 0; i < n - 1; i++)
    {
        min = i;
        for (j = i + 1; j <= n - 1; j++)
            if (A[j] < A[min])
                min = j;
        if (min != i)
        {
            x = A[min]; A[min] = A[i]; A[i] = x;
        }
    }
}

void insertion_sort(int A[], int n)
{
    int i, j, x;
    for (i = 1; i < n; i++)
    {
        x = A[i];
        j = i - 1;
        while (j >= 0 && x < A[j])
        {
            A[j + 1] = A[j];
            j--;
        }
        A[j + 1] = x;
    }
}

void bubble_sort(int A[], int n)
{
    int i, j, x;
    for (i = 0; i < n - 1; i++)
        for (j = n - 1; j > i; j--)
            if (A[j] < A[j - 1])
            {
                x = A[j];
                A[j] = A[j - 1];
                A[j - 1] = x;
            }
}

void bubble_sort_flag(int A[], int n)
{
    int i, x, flag;
    do
    {
        flag = 1;
        for (i = 0; i < n - 1; i++)
            if (A[i] > A[i + 1])
            {
                x = A[i];
                A[i] = A[i + 1];
                A[i + 1] = x;
                flag = 0;
            }
    } while (!flag);
}

void generateArray(int A[], int n)
{
    for (int i = 0; i < n; i++)
    {
        A[i] = rand() % 10000;
    }

}

void measureTime(void(*sortFunc)(int[], int), int A[], int n, const char* sortName)
{
    int* coppyArr = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++)
    {
        coppyArr[i] = A[i];
    }

    int t1, t2;
    t1 = GetTickCount();
    sortFunc(coppyArr, n);

    t2 = GetTickCount();

    printf_s("%s: %d", sortName, t2 - t1);

}


int main()
{
    int sizes[] = { 1000, 2000, 5000, 10000, 20000, 50000 };
    srand((unsigned)time(NULL));

    for (int i = 0; i < sizeof(sizes) / sizeof(sizes[0]); i++)
    {
        int size = sizes[i];
        int* arr = (int*)malloc(size * sizeof(int));
        generateArray(arr, size);

        measureTime(selection_sort, arr, size, "Selection Sort");
        measureTime(insertion_sort, arr, size, " Insertion Sort");
        measureTime(bubble_sort, arr, size, "Bubble Sort");
        measureTime(bubble_sort_flag, arr, size, "Bubble Flag Sort");
    }

}
