# 📝 AGB (Auto Grader & Builder)
리눅스 환경에서의 C 언어 과제 자동 채점 및 빌드 시스템
## 1. 프로젝트 개요 (Overview)
AGB는 다수의 학생이 제출한 C 소스 코드를 리눅스 쉘 스크립트를 통해 자동으로 컴파일하고, 정해진 입력값을 주입하여 정답 여부를 판별하는 자동 채점 도구입니다.
반복적인 채점 과정을 자동화하여 시간을 단축하고, 휴먼 에러를 방지하기 위해 기획되었습니다.
## 2. 주요 기능 (Features)

| 기능 | 설명 | 구현 기술 |
|------|------|-----------|
| 자동 컴파일 | src 폴더 내의 모든 .c 파일을 탐색하여 일괄 빌드합니다.  | `find`, `gcc`, `while read` |
| 에러 핸들링 | 컴파일 실패 시 에러 로그를 별도 파일(build_error.log)에 격리 저장합니다. |   `2>>` (Stderr Redirection)        |
|  자동 채점    |  입력값 주입 및 정답 파일과의 diff 비교를 통해 Pass/Fail을 판정합니다.    |    `Pipe(`       |
| 결과 리포팅   |  채점 결과를 요약하여 날짜별 리포트 파일로 생성합니다.    |    `date`, `whoami`, `Block Redirection`       |
|  백업 모드    |  환경변수 제어를 통해 결과물과 소스코드를 자동으로 압축 백업합니다.    |   `export`, `if`, `tar`     |

## 3. 설치 및 실행 방법 (How to Use)
### 3.1. 사전 준비 (Prerequisites)
이 프로젝트는 리눅스 환경(Ubuntu 권장)에서 동작하며 gcc가 필요합니다.
sudo apt update
sudo apt install gcc make


### 3.2. 설치 (Installation)
git clone [여기에_당신의_레포지토리_URL]
cd [프로젝트_폴더명]
chmod +x grader.sh


### 3.3. 실행 (Usage)
기본 실행 (Basic Mode)
./grader.sh


### 백업 모드 실행 (Backup Mode)
채점 후 소스코드와 로그를 backup/ 폴더에 .tar.gz로 압축 보관합니다.
export MODE=backup
./grader.sh


## 4. 디렉토리 구조 (Directory Structure)
```
.
├── grader.sh           # 메인 실행 스크립트
├── src/                # 채점 대상 소스코드 (.c)
├── data/               # 테스트 데이터
│   ├── input.txt       # 입력값
│   └── answer.txt      # 정답지
├── logs/               # 실행 로그 저장소
│   ├── build_error.log # 컴파일 에러 기록
│   └── result_*.txt    # 최종 결과 리포트
└── backup/             # 백업 압축 파일 저장소
```

## 5. 실행 결과 화면 (Screenshots)

✅ 정상 실행 및 채점 화면

<img width="448" height="501" alt="image" src="https://github.com/user-attachments/assets/11f3f4f3-14d6-4beb-8e5a-34051fd3f245" />

백업 모드 실행 결과

<img width="1160" height="646" alt="image" src="https://github.com/user-attachments/assets/34527277-a3b8-44ba-adae-1a41c5ae147d" />

❌ 컴파일 에러 및 로그 확인

<img width="1529" height="579" alt="image" src="https://github.com/user-attachments/assets/f12e8e81-c277-493f-b13a-0f7f8bc172a3" />


## 6. 팀원 및 역할 (Team)
이명진 ([@septeratz](https://github.com/septeratz)): 프로젝트 기획, compile_code, generate_report 구현, Git 관리

성민철 ([@Mitchell215](https://github.com/Mitchell215)): run_tests 구현, 테스트 케이스 설계, 통합 테스트
