#include <stdio.h>
#include <stdlib.h> 
#include <string.h>
#include <ctype.h> 

void print_binary(unsigned long long val, int bits) {
    for (int i = bits - 1; i >= 0; --i) {
        putchar((val & (1ULL << i)) ? '1' : '0');
    }
}

int main() {
    int n;
    do {
        printf("Please enter the number of bits between 1 and 32 inclusively: ");
        if (scanf("%d", &n) != 1 || n < 1 || n > 32) {
            printf("Invalid input. Please enter a number between 1 and 32.\n");
            int c;
            while ((c = getchar()) != '\n' && c != EOF);
        } else {
            int c;
            while ((c = getchar()) != '\n' && c != EOF);
        }
    } while (n < 1 || n > 32);

    long long min_val = -(1LL << (n - 1));
    long long max_val = (1LL << (n - 1)) - 1;

    char line[100];
    long long k;
    int is_neg_zero = 0;
    int valid;

    do {
        valid = 0;
        printf("Please enter a number between %lld and %lld inclusively: ", min_val, max_val);
        if (fgets(line, sizeof(line), stdin) == NULL) {
            printf("Input error.\n");
            continue;
        }

        // Remove trailing newline
        line[strcspn(line, "\n")] = '\0';

        // Trim leading and trailing whitespace
        char *trimmed = line;
        while (isspace((unsigned char)*trimmed)) trimmed++;
        char *end = trimmed + strlen(trimmed) - 1;
        while (end >= trimmed && isspace((unsigned char)*end)) end--;
        *(end + 1) = '\0';

        if (strcmp(trimmed, "-0") == 0) {
            is_neg_zero = 1;
            k = 0;
            valid = 1;
        } else if (strlen(trimmed) > 0) {
            char *endptr;
            k = strtoll(trimmed, &endptr, 10);
            if (endptr != trimmed && *endptr == '\0' && k >= min_val && k <= max_val) {
                is_neg_zero = 0;
                valid = 1;
            }
        }

        if (!valid) {
            printf("Invalid input. Please enter a number in the specified range.\n");
        }
    } while (!valid);

    long long max_mag = (1LL << (n - 1)) - 1;

    if (is_neg_zero) {
        // Special output for -0
        printf("The sign-magnitude representation of -0 is ");
        putchar('1');
        for (int i = 1; i < n; ++i) putchar('0');
        printf(".\n");

        printf("The 1's complement representation of -0 is ");
        for (int i = 0; i < n; ++i) putchar('1');
        printf(".\n");

        printf("The 2's complement doesn't represent -0.\n");
    } else {
        // Normal output
        long long abs_k = llabs(k);
        int sm_can = (abs_k <= max_mag);
        int oc_can = (abs_k <= max_mag);

        if (sm_can) {
            printf("The sign-magnitude representation of %lld is ", k);
            putchar(k < 0 ? '1' : '0');
            print_binary((unsigned long long)abs_k, n - 1);
            printf(".\n");
        } else {
            printf("The sign-magnitude doesn't represent %lld.\n", k);
        }

        if (oc_can) {
            printf("The 1's complement representation of %lld is ", k);
            if (k >= 0) {
                print_binary((unsigned long long)k, n);
            } else {
                unsigned long long all_ones = (1ULL << n) - 1;
                unsigned long long rep = all_ones ^ (unsigned long long)abs_k;
                print_binary(rep, n);
            }
            printf(".\n");
        } else {
            printf("The 1's complement doesn't represent %lld.\n", k);
        }

        printf("The 2's complement representation of %lld is ", k);
        unsigned long long tc_rep = (k >= 0 ?
            (unsigned long long)k :
            (unsigned long long)(k + (1ULL << n)));
        print_binary(tc_rep, n);
        printf(".\n");
    }

    return 0;
}