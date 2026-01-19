#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long powerOfTwo(int n) {
    long long result = 1;
    for (int i = 0; i < n; i++) {
        result = result * 2;
    }
    return result;
}

void printBinary(long long number, int bits) {
    for (int i = bits - 1; i >= 0; i--) {
        long long mask = 1LL << i;
        
        if ((number & mask) != 0) {
            printf("1");
        } else {
            printf("0");
        }
    }
}

int main() {
    int bits;
    long long inputNum;
    long long minVal, maxVal;
    char inputBuffer[100];
    int isNegZero = 0;

    printf("Please enter the number of bits between 1 and 32 inclusively: ");
    scanf("%d", &bits);

    if (bits < 1 || bits > 32) {
        return printf("Please enter valid number within range.");
    }

    long long halfRange = powerOfTwo(bits - 1);
    
    minVal = -halfRange;          
    maxVal = halfRange - 1;       

    printf("Please enter a number between %lld and %lld inclusively: ", minVal, maxVal);
    scanf("%s", inputBuffer);
    
    inputNum = atoll(inputBuffer);
    
    if (strcmp(inputBuffer, "-0") == 0) {
        isNegZero = 1;
    }

    if (inputNum < minVal || inputNum > maxVal) {
        return printf("Please enter valid number within range.");
    }
    
    if (inputNum < -maxVal || inputNum > maxVal) {
        printf("The sign-magnitude doesn't represent %lld.\n", inputNum);
    } 
    else {
        printf("The sign-magnitude representation of %lld is ", inputNum);
        
        if (inputNum < 0 || isNegZero) {
            printf("1");
        } 
        else {
            printf("0");
        }
        
        long long magnitude = llabs(inputNum); 
        printBinary(magnitude, bits - 1);
        printf(".\n");
    }

    if (inputNum < -maxVal || inputNum > maxVal) {
        printf("The 1's complement doesn't represent %lld.\n", inputNum);
    } 
    else {
        printf("The 1's complement representation of %lld is ", inputNum);
        
        long long valueToPrint;
        
        if (inputNum >= 0 && !isNegZero) {
            valueToPrint = inputNum;
        } 
        else {
            long long allOnes = powerOfTwo(bits) - 1;
            valueToPrint = allOnes - llabs(inputNum);
        }
        
        printBinary(valueToPrint, bits);
        printf(".\n");
    }

    if (inputNum < minVal || inputNum > maxVal || isNegZero) {
        printf("The 2's complement doesn't represent %s.\n", isNegZero ? "-0" : inputBuffer);
    } 
    else {
        printf("The 2's complement representation of %lld is ", inputNum);
        
        long long valueToPrint;
        
        if (inputNum >= 0) {
            valueToPrint = inputNum;
        } 
        else {
            valueToPrint = powerOfTwo(bits) + inputNum;
        }
        
        printBinary(valueToPrint, bits);
        printf(".\n");
    }    
}