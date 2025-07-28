#!/bin/bash

# 백업 경로 설정
BACKUP_DIR="<backup_dir>"
DATE=$(date +"%Y-%m-%d")      # 날짜 형식: YYYY-MM-DD
BACKUP_PATH="$BACKUP_DIR/database-backup-$DATE"

# 환경 변수
MONGO_CONTAINER="mago-op-database"
MONGO_USER="orangeplanet"
MONGO_PASSWORD="innovation!"
MONGO_HOST="localhost"
MONGO_PORT="27017"

# 백업 디렉토리 생성
mkdir -p $BACKUP_PATH

# MongoDB 백업 실행
docker exec $MONGO_CONTAINER mongodump \
  --host $MONGO_HOST \
  --port $MONGO_PORT \
  --username $MONGO_USER \
  --password $MONGO_PASSWORD \
  --authenticationDatabase admin \
  --out /data/backup

# 백업 파일 압축
docker cp $MONGO_CONTAINER:/data/backup $BACKUP_PATH
tar -czf "$BACKUP_PATH.tar.gz" -C $BACKUP_PATH .

# 백업 디렉토리 정리
rm -rf $BACKUP_PATH

# 7일 이상 된 백업 파일 삭제
# find $BACKUP_DIR -type f -name "*.tar.gz" -mtime +7 -exec rm {} \;

# 로그 메시지
echo "MongoDB backup completed: $BACKUP_PATH.tar.gz"