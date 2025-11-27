#!/bin/bash

# ==============================================================================
# Linux Project: Auto Grader & Builder (AGB)
# ==============================================================================
# 사용법: ./grader.sh
# ------------------------------------------------------------------------------

# --- 1. 환경 설정 및 변수 정의 ---
SRC_DIR="./src"
DATA_DIR="./data"
LOG_DIR="./logs"
BACKUP_DIR="./backup"
INPUT_FILE="$DATA_DIR/input.txt"
ANSWER_FILE="$DATA_DIR/answer.txt"
RESULT_FILE="$LOG_DIR/result_$(date +%Y%m%d).txt"
BUILD_LOG="$LOG_DIR/build_error.log"

# 색상 코드 (출력 꾸미기용)
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# 초기화: 로그 파일 초기화
mkdir -p "$LOG_DIR" "$BACKUP_DIR"
> "$BUILD_LOG"
> "$RESULT_FILE"

echo "========================================"
echo "      Auto Grader & Builder Start       "
echo "========================================"

# --- 2. 함수 정의 (각 팀원이 구현할 부분) ---

# [팀원 1 담당] 자동 컴파일 함수
compile_code() {
    echo -e "\n[Step 1] Compiling sources..."
    
    # TODO: SRC_DIR 내의 모든 .c 파일을 찾아서 컴파일 하세요.
    # 1. find 명령어로 .c 파일 찾기
    # 2. 반복문(for)을 돌면서 gcc로 컴파일
    # 3. 성공하면 실행파일 생성, 실패하면 에러 메시지를 BUILD_LOG에 저장
    
    # 힌트:
    # for file in $(find "$SRC_DIR" -name "*.c"); do
    #    gcc "$file" -o "${file%.c}.out" 2>> "$BUILD_LOG"
    #    ...
    # done
}

# [팀원 2 담당] 실행 및 테스트 함수
run_tests() {
    echo -e "\n[Step 2 & 3] Running tests and Checking results..."
    
    # TODO: 컴파일된 실행 파일(*.out)들을 찾아서 실행하고 결과를 비교하세요.
    # 1. 실행 파일 실행 시 INPUT_FILE 내용을 입력으로 주입 (<)
    # 2. 실행 결과를 임시 파일에 저장 (>)
    # 3. diff 명령어로 ANSWER_FILE과 비교
    # 4. 결과에 따라 PASS(초록색)/FAIL(빨간색) 출력
    
    # 힌트:
    # ./executable < "$INPUT_FILE" > temp_output.txt
    # diff_result=$(diff -w temp_output.txt "$ANSWER_FILE")
}

# [팀원 1 담당] 결과 리포트 및 백업 함수
generate_report() {
    echo -e "\n[Step 4] Generating Report..."
    
    # TODO: 최종 결과 파일(RESULT_FILE)에 점수나 통과한 파일 목록을 정리해두세요.
    # TODO: 환경변수 MODE가 "backup"이면 소스코드와 로그를 압축(tar)해서 BACKUP_DIR로 이동
    
    echo "Report saved to $RESULT_FILE"
}

# --- 3. 메인 실행 로직 ---

# 각 함수 순차 실행
compile_code
run_tests
generate_report

echo -e "\nAll tasks finished."