#include <iostream>
#include "../../SimpleBench/simple-bench.h"


#define ARR_SIZE 100

extern "C" int get_min_asm(const int* arr, unsigned int len);


int min_max(const int* arr, unsigned int len)
{
    int max;
    int min;
    
    min = arr[0];
    max = arr[1];

    for (int i = 0; i < len; i++)
    {
        if (min > arr[i])
            min = arr[i];
        else if (max < arr[i])
            max = arr[i];
    }

    return min;
}

void FisherShuf(int* arr, unsigned int len)
{
    int n;
    for (int i = (len-1); i > 0; i--)
    {
        int tmp = arr[i];
        n = rand() % i;
        arr[i] = arr[n];
        arr[n] = tmp;
    }
}

int main()
{
    struct timespec start, end;
    int arr[ARR_SIZE];
    
    srand(time(NULL));

    for (int i = 0; i < ARR_SIZE; i++)
        arr[i] = (rand() % 10)+rand();


    simple_gettime(&start);
        for (int i = 0; i < 1000000; i++)
            min_max(arr, ARR_SIZE);
    simple_gettime(&end);
    printf("Time:%lf\n", diff(start, end));
    printf("%d\n", min_max(arr, ARR_SIZE));

    simple_gettime(&start);
        for (int i = 0; i < 1000000; i++)
            get_min_asm(arr, ARR_SIZE);
    simple_gettime(&end);
    printf("Time:%lf\n", diff(start, end));
    printf("%d\n", get_min_asm(arr, ARR_SIZE));

}
