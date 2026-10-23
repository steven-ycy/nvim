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
    int a = 2;
    a = 5;
    a = 7;
    printf("this is a message\n");
    int e = 0;
    e = test();
    scanf("%d", &e);
    printf("this is your input %d\n", e);
    scanf("%d");
    return 0;
}
