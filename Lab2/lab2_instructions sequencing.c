#include <stdio.h>

int main() {
    int n = 44;
    long long fib_prev = 0;     // F(0)
    long long fib_curr = 1;     // F(1)
    long long fib_next;

    if (n == 0) {
        printf("Fibonacci(%d) = %lld\n", n, fib_prev);
        return 0;
    } else if (n == 1) {
        printf("Fibonacci(%d) = %lld\n", n, fib_curr);
        return 0;
    }

    for (int i = 2; i <= n; i++) {
        fib_next = fib_prev + fib_curr;
        fib_prev = fib_curr;
        fib_curr = fib_next;
    }

    printf("Fibonacci(%d) = %lld\n", n, fib_curr);
    return 0;
}