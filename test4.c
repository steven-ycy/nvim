#include <stdio.h>

int main(void) {
    int a, b;
    // 透過標準輸入讀取兩個數字
    if (scanf("%d %d", &a, &b) == 2) {
        printf("成功讀取兩個數字: a = %d, b = %d\n", a, b);
        printf("兩數總和: %d\n", a + b);
    } else {
        printf("讀取失敗，請確認輸入格式！\n");
    }
    return 0;
}
