#include <stdio.h>

int main() {
    int n = 44;
    long long prev = 0;   
    long long curr = 1;  
    long long next;

    for (int i = 2; i <= n; i++) {
        next = prev + curr;
        prev = curr;
        curr = next;
    }

    printf("Fibonacci of %d is %lld", n, curr);
}