#include <stdio.h>
#include <stdlib.h>

int test() {
    printf("this is not your case\n");
    int sum = 0;
    for (int a = 0; a < 12; a++) {
        sum += a;
    }
    return sum;
}
int main() {
    int a[2] = {0};
    a[0] = 5;
    a[1] = 7;
    printf("this is a message\n");
    int e = 0;
    e = test();
    printf("this is your input %d\n", e);
    a[1] = 4;
    for (int b = 0; b < 2; b++) {
        a[b] = b;
    }
    return 0;
}
