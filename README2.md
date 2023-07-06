

## 기본 패키지 설치
```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
```

## Docker에서 제공하는 패키지 저장소 등록

## 패키지 저장소에서 제공하는 인증키(gpg) 등록
```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

### 패키지 저장소 경로 GPG 키와 함께 등록
```bash
echo \
 "deb [arc="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings]
```

 ### 등록한 패키지 저장소 적용

```bash
sudo apt-get update
```

## Docker 설치
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```


### 설치 후 확인
```bash
docker -v
```


### Docker Token 등록
1. DC01 디렉토리로 이동
2. DC01 디렉토리에서 env 디렉토리 생성
3. env 디렉토리 안에 docker_token 파일 생성
4. [docker hub](https://hub.docker.com/settings/security) 사이트 접속
5. docker token 생성 후 발급된 token을 docker_token에 기록 후 저장

현재 README.md 파일이 있는 위치에 env 디렉토리를 생성하고 env 디렉토리 안에 
docker_token 파일을 생성하여 [docker hub](https://hub.docker.com/settings/security) 
사이트 접속하여 생성한 Token을 등록합니다.