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
    
    # 컴파일 성공/실패 카운트 변수
    local success_count=0
    local fail_count=0

    # 1. src 디렉토리 내의 모든 .c 파일 찾기 (while loop 사용)
    # find 명령어로 찾은 파일 경로를 하나씩 읽어서 file 변수에 담음
    while read -r file; do
        # 2. 출력 파일명 생성 (예: src/student1.c -> src/student1.out)
        # ${file%.c}는 파일명 뒤의 .c를 제거하는 쉘 문법입니다.
        output_file="${file%.c}.out"
        
        # 3. gcc로 컴파일 실행
        # -o: 실행 파일 이름 지정
        # 2>>: 에러 메시지(Standard Error)를 BUILD_LOG 파일에 이어쓰기(append)
        gcc "$file" -o "$output_file" 2>> "$BUILD_LOG"
        
        # 4. 컴파일 결과 확인 ($?는 바로 앞 명령어의 종료 코드. 0이면 성공)
        if [ $? -eq 0 ]; then
            echo -e "  - $file: ${GREEN}Success${NC}"
            ((success_count++))
        else
            echo -e "  - $file: ${RED}Fail${NC} (Check $BUILD_LOG)"
            # 로그 파일에 어떤 파일에서 에러가 났는지 구분선 추가
            echo "----------------------------------------" >> "$BUILD_LOG"
            echo "Error occurred in: $file" >> "$BUILD_LOG"
            echo "----------------------------------------" >> "$BUILD_LOG"
            ((fail_count++))
        fi

    done < <(find "$SRC_DIR" -name "*.c")

    echo -e "  Result: Success ${GREEN}$success_count${NC}, Fail ${RED}$fail_count${NC}"
}
# [팀원 2 담당] 실행 및 테스트 함수
run_tests() {
    echo -e "\n[Step 2] Running tests..."

    # 컴파일된 .out 파일 찾아서 실행
    while read -r exec_file; do
        echo "▶️ Executing $exec_file..."
        
        # .out 확장자 제거하고 파일명만 추출.
        # 이후 filename을 가지고 임시 파일 생성.
        filename=$(basename "$exec_file" .out)
        temp_output="/tmp/output_${filename}.txt"

        # 1. 실행 파일 실행 시 INPUT_FILE 내용을 입력으로 주입 (<)
        # 2. 실행 결과를 임시 파일에 저장 (>)
        # 실행 파일 실행 input.txt를 stdin으로 주입
        "$exec_file" < "$INPUT_FILE" > "$temp_output" 2>/dev/null # exac_file의 실행 후 에러 메세지 버림. why? 출력 값에만 집중.
        
        echo "📁 → Output saved to $temp_output" # 출력 저장 위치 출력
        
    done < <(find "$SRC_DIR" -name "*.out" -type f)
    
    echo "  All tests executed."

    echo -e "\n[Step 3] Checking results..."
    
    #TODO: 실행 후 결과를 결과 파일과 비교
    # 3. diff 명령어로 ANSWER_FILE과 비교
    # 4. 결과에 따라 PASS(초록색)/FAIL(빨간색) 출력
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