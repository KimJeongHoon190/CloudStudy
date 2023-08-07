# Ubuntu 20.04에 Docker 설치

## 기본 패키지 설치
```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
```

## Docker에서 제공하는 패키지 저장소 등록

### 패키지 저장소에서 제공하는 인증키(gpg) 등록
```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

### 패키지 저장소 경로 GPG 키와 함께 등록
```bash
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
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
# Docker version 24.0.2, build cb74dfc
```

### vagrant가 docker 명령어를 사용할 수 있게 만들기
```bash
sudo usermod -a -G docker vagrant # vagrant 계정을 docker 그룹에 가입시키므로 docker 명령어를 sudo 없이 사용가능하다.
newgrp docker  # vagrant를 docker 그룹에 가입시킨 내용을 적용시키는 명령어
groups # vagrant가 가입한 그룹 목록 확인
```

### Docker Token 등록
1. DC01 디렉토리로 이동
2. DC01 디렉토리에서 env 디렉토리 생성
3. env 디렉토리 안에 docker_token 파일 생성
4. [docker hub](https://hub.docker.com/settings/security) 사이트 접속
5. docker token 생성 후 발급된 token을 docker_token에 기록 후 저장

### Docker Token을 가져와서 로컬 파일로 저장하기

현재 README.md 파일이 있는 위치에 env 디렉토리를 생성하고 env 디렉토리 안에 
docker_token 파일을 생성하여 [docker hub](https://hub.docker.com/settings/security) 
사이트 접속하여 생성한 Token을 등록합니다.

### Docker Token으로 로그인 성공하기

도커 토큰 파일을 /vagrant/env/docker_token 경로에 저장합니다.
```bash
docker login -u hedgehoon --password-stdin < /vagrant/env/docker_token
# 해당 경로의 파일에 저장된 도커 토큰을 가져와 hedgehoon이라는 도커 계정으로 자동 로그인 합니다.
```