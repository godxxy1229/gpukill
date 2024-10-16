#!/bin/bash

# 가장 많은 GPU 메모리를 사용 중인 프로세스를 찾아 종료하는 스크립트

# nvidia-smi를 사용해 GPU 프로세스 목록을 가져오고, 가장 큰 메모리 사용량을 가진 프로세스를 찾습니다.
LARGEST_INFO=$(nvidia-smi --query-compute-apps=pid,process_name,used_memory --format=csv,noheader,nounits | sort -k3 -nr | head -n 1)

# PID, 프로세스 이름, 메모리 사용량을 각각 변수로 저장합니다.
LARGEST_PID=$(echo $LARGEST_INFO | awk '{print $1}' | sed 's/,//')
PROCESS_NAME=$(echo $LARGEST_INFO | awk '{print $2}')
LARGEST_MEMORY=$(echo $LARGEST_INFO | awk '{print $3}')

# PID가 없으면 종료
if [ -z "$LARGEST_PID" ]; then
    echo "현재 실행 중인 GPU 프로세스를 찾을 수 없습니다."
    exit 1
fi

# PID를 기반으로 사용자를 확인합니다.
USER=$(ps -o user= -p $LARGEST_PID 2>/dev/null)

# 메모리 사용량 기준 (예: 32 MiB 이상일 때만 종료)
MEMORY_LIMIT=32

# 가장 큰 메모리 사용 프로세스의 정보를 출력
echo "가장 많은 메모리를 사용하는 프로세스 정보:"
echo "사용자: ${USER:-알 수 없음}"
echo "PID: $LARGEST_PID"
echo "프로세스 이름: $PROCESS_NAME"
echo "GPU 메모리 사용량: $LARGEST_MEMORY MiB"

# 메모리 사용량이 기준을 초과하는지 확인
if [ "$LARGEST_MEMORY" -gt "$MEMORY_LIMIT" ]; then
    # 사용자에게 프로세스를 종료할 것인지 물어봅니다.
    read -p "이 프로세스를 종료하시겠습니까? [y/N]: " CONFIRM
    if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "프로세스 $LARGEST_PID (사용자: ${USER:-알 수 없음})를 종료합니다..."
        kill -9 $LARGEST_PID
        echo "프로세스 $LARGEST_PID가 종료되었습니다."
    else
        echo "프로세스 종료가 취소되었습니다."
    fi
else
    echo "$LARGEST_PID번 프로세스가 $LARGEST_MEMORY MiB의 GPU 메모리를 사용 중이며, 설정된 기준인 $MEMORY_LIMIT MiB를 초과하지 않습니다."
    echo "프로세스를 종료하지 않습니다."
fi
