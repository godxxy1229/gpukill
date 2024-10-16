# GPU 메모리 관리 스크립트 (`gpukill`)

## 개요
본 스크립트는 GPU의 유휴 상태를 알려주고 가장 많은 메모리를 사용하는 프로세스를 종료할 수 있도록 지원합니다.

이를 통해 연구실처럼 공용으로 사용하는 서버 GPU 자원을 효율적으로 관리하고, 불필요한 점유를 줄일 수 있습니다.

## 주요 기능
- GPU의 전력 사용량, 사용률, 메모리 사용량을 토대로 유휴상태 확인
- NVIDIA GPU 상에서 실행 중인 프로세스 중 메모리 사용량이 가장 큰 프로세스 감지
- 해당 프로세스의 사용자명, 프로세스명, 메모리 사용량 정보 제공
- 사용자 확인 후 선택적으로 프로세스 종료

## 시스템 요구 사항
- NVIDIA GPU 및 드라이버 설치
- Linux 운영체제
- `ps`, `awk`, `sort`, `sed`, `bash` 등 기본 명령어 지원

## 설치 방법
1. 스크립트를 `/usr/local/bin`에 복사:
    ```bash
    sudo cp kill_gpu_process.sh /usr/local/bin/gpukill
    ```
2. 스크립트에 실행 권한 부여:
    ```bash
    sudo chmod +x /usr/local/bin/gpukill
    ```
3. 사용자 권한 설정 (`/etc/sudoers` 수정):
    ```plaintext
    ALL ALL=(ALL) NOPASSWD: /usr/local/bin/gpukill
    ```

4. `alias` 설정 (`/etc/bashrc` 또는 `/etc/profile`):
    ```bash
    alias gpukill="sudo /usr/local/bin/gpukill"
    ```

## 사용 예시
```bash
gpukill
```

## 출력 예시
```js
0번 GPU가 유휴 상태로 감지되었습니다.
가장 많은 메모리를 사용하는 프로세스 정보:
사용자: testuser1
PID: 124113
프로세스 이름: /bin/python
GPU 메모리 사용량: 5422 MiB
이 프로세스를 종료하시겠습니까? [y/N]: y
프로세스 124113 (사용자: testuser1)를 종료합니다...
프로세스 124113가 종료되었습니다.
```

## 문제 해결
  1. 스크립트가 실행되지 않는 경우 실행 권한 부여 확인:
    ```bash
    sudo chmod +x /usr/local/bin/gpukill
    ```
  2. alias가 작동하지 않는 경우 sh 명령어로 실행:
    ```bash
    alias gpukill="sh /usr/local/bin/gpukill"
    ```
