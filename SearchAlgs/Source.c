#include <stdio.h>
#include "simple-bench.h"


extern unsigned asm_search(const int* arr, unsigned len, int elem);

unsigned search(const int* arr, unsigned len, int elem)
{
	for (int i = 0; i < len; i++)
		if (arr[i] == elem)
			return i;
}

int main()
{
	struct timespec start, end;
	int arr[10000];

	srand(time(NULL));

	for (int i = 0; i < 10000; i++)
	{
		arr[i] = rand() % 10000;
	}
	simple_gettime(&start);
	for(int i = 0; i < 200000; i++)
		search(arr, 10000, 0);
	simple_gettime(&end);
	printf("Time:%lf\n", diff(start, end));

	printf("%d\n", search(arr, 1000, 0));

	simple_gettime(&start);
	for (int i = 0; i < 200000; i++)
		asm_search(arr, 10000, 0);
	simple_gettime(&end);
	printf("Time:%lf\n", diff(start, end));

	printf("%d\n", asm_search(arr, 10000, 0));
}