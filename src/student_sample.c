#include <stdio.h>

int main() {
    int a, b;
    // 사용자 입력을 유도하는 메시지 출력 (정답 파일과 비교 시 중요)
    printf("Input two numbers: ");
    
    // 두 정수 입력 받기
    if (scanf("%d %d", &a, &b) != 2) {
        return 1;
    }
    
    // 결과 출력
    printf("Sum: %d\n", a + b);
    
    return 0;
}