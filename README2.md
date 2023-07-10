

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
