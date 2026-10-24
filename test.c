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
    scanf("%d", &e);
    printf("this is your input %d\n", e);
    a[e] = 2;
    a[3] = 4;
    for (int b = 0; b < 5; b++) {
        a[b] = b;
    }
    scanf("%d");
    return 0;
}
