/* initArrayStruct.c
 *
 * This program calls three assembly language functions to
 * help exercise and verify their behavior.
 * 
 * 2020-04-28: Mark Gondree
 */

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>

/* fillFibonacciArray
 *
 * The first argument is an array of size at least n.
 * The function writes into the array the first
 * n fibonacci numbers, i.e., the sequence starting
 *    1, 1, 2, 3, 5, 8, 13, ...
 * where each element is the sum of the prior two
 * elements.
 *
 * The fibonacci sequence grows quickly, exceeding
 * the register size. You may ignore overflows.
 *
 * Note: your implementation must use ldr and/or str using
 * pre-index and post-indexing, rather than
 * adjusting the addresses in another fashion, like
 * using add.
 */
void fillFibonacciArray(int *array, int n);


/* struct fib
 *
 * This is a struct that holds three values
 * which are part of a sequence. It is used
 * by fillFibonacciStruct
 */
struct fib {
    int a;  // holds element F[i-2]
    int b;  // holds element F[i-1]
    int c;  // holds element F[i]
};


/* fillFibonacciStruct
 * 
 * Saves struct fib members a and b with a and b,
 * respectively, and stores member c as a+b
 */
void fillFibonacciStruct(struct fib* f, int a, int b);


int main()
{
    int i, n, m, ret;
    int *A;
    struct fib *F;

    // Test 1
    n = 45;
    A = malloc(n*sizeof(int));
    memset(A, -1, n);
    fillFibonacciArray(A, 0);

    // Test 2
    assert(A[0] == -1);
    fillFibonacciArray(A, 1);
    assert(A[0] == 1);
    assert(A[1] == -1);

    // Test 3
    fillFibonacciArray(A, 2);
    assert(A[0] == A[1] == 1);
    assert(A[3] == -1);

    // Test 4
    memset(A, 0, n);
    fillFibonacciArray(A, n);
    assert(A[0] == 1);
    assert(A[1] == 1);
    printf("First %d numbers of Fibonacci sequence: 1 1 ", n);
    for (i=2; i<n; i++) {
        printf("%d ", A[i]);
	assert(A[i] == A[i-1] + A[i-2]);
    }
    printf("\n");

    // Test 5
    srand(time(NULL));
    m = rand() % 100;
    F = malloc(m*sizeof(struct fib));
    memset(F, 0, m*sizeof(struct fib));
    printf("Address of: \n\tX\t%p\n\tX.a\t%p\n\tX.b\t%p\n\tX.c\t%p\n", 
           &F[m-2], &F[m-2].a, &F[m-2].b, &F[m-2].c);
    fillFibonacciStruct(&F[m-2], A[10], A[11]);
    assert(F[m-2].a == A[10]);
    assert(F[m-2].b == A[11]);
    assert(F[m-2].c == A[10] + A[11]);
    for (i = 0; i < m-2; i++) {
        assert(F[i].a == F[i].b == F[i].c == 0);
    }
    assert(F[m-1].a == F[m-1].b == F[m-1].c == 0);
    

    free(F);
    free(A);
    return 0;
}