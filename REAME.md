# Mago OP MongoDB

Mago OP 프로젝트를 위한 MongoDB 데이터베이스 환경 설정 및 관리 도구입니다.

## 구성 요소

이 프로젝트는 다음 구성 요소들을 포함합니다:

- **MongoDB**: NoSQL 데이터베이스 서버
- **Mongo Express**: MongoDB 웹 기반 관리 도구

## 설치 및 실행

### 네트워크 생성

먼저 외부 네트워크를 생성해야 합니다:

```bash
docker network create mago-op-network
```

이 네트워크를 통해서 외부에서 접속할 수 있습니다. 같은 네크워크에 있는 컨테이너끼리는 자동으로 통신이 가능합니다.

### 서비스 시작

프로젝트 루트 디렉토리에서 다음 명령어를 실행합니다:

```bash
# 백그라운드에서 모든 서비스 시작
docker compose up -d
```

Docker image는 Docker Hub에서 가져옵니다. 따라서 인터넷 연결이 필요합니다.

## 접속 정보

### MongoDB 데이터베이스

- **호스트**: localhost
- **포트**: 7017
- **사용자명**: orangeplanet
- **비밀번호**: innovation!
- **연결 URL**: `mongodb://orangeplanet:innovation!@localhost:7017`

### Mongo Express (웹 관리 도구)

- **URL**: http://localhost:7018
- **사용자명**: orangeplanet
- **비밀번호**: innovation!

Mongo Express를 통해 웹 브라우저에서 MongoDB 데이터베이스를 쉽게 관리할 수 있습니다.

## 데이터 지속성

MongoDB 데이터는 `mago_op_data` Docker 볼륨에 저장됩니다. 컨테이너를 삭제해도 데이터는 유지됩니다.

### 볼륨 관리

```bash
# 볼륨 확인
docker volume ls

# 볼륨 상세 정보
docker volume inspect mago_op_data

# 볼륨 삭제 (주의: 모든 데이터가 삭제됩니다)
docker volume rm mago_op_data
```

## 문제 해결

### 포트 충돌

기본 포트(7017, 7018)가 이미 사용 중인 경우, `docker-compose.yml` 파일에서 포트를 변경할 수 있습니다:

```yaml
ports:
  - "새포트:27017"  # MongoDB용
  - "새포트:8081"   # Mongo Express용
```

### 네트워크 문제

외부 네트워크가 존재하지 않는 경우:

```bash
docker network create mago-op-network
```

## 보안 참고사항

⚠️ **중요**: 이 설정은 개발 환경용입니다. 프로덕션 환경에서는 다음 사항을 고려하세요:

- 강력한 비밀번호 사용
- 네트워크 보안 설정
- SSL/TLS 암호화
- 방화벽 설정
- 정기적인 백업

