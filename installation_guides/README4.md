## Jenkins 설치 및 사용법

### 준비물 : Ubuntu 20.04에 Docker 설치(README2.md) 파일 실습 완료 

### 도커 로그인
```bash
docker login -u hedgehoon --password-stdin < /vagrant/env/docker_token
```

### Jenkins 실행하기
```bash
#docker run -it -d -p 8080:8080 --name jenkins jenkins/jenkins:2.387.2-lts 기본(불편하다)
docker volume create jenkins-volume
docker volume ls # 볼륨(세이브 포인트) 확인용
docker run -it -d -p 8080:8080 --restart=always --name jenkins -v jenkins-volume:/var/jenkins_home/ -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker jenkins/jenkins:2.387.2-lts 
# 도커 볼륨을 사용해서 진행 사항을 저장하고(volume) 언제나 자동으로 다시 시작하게(--restart=always) 하려면 위의 주석 처리한 기본 명령어 말고 바로 위의 명령어 세 개를 써라
```

### 도커 프로세스 확인
```bash
docker ps -a
```

### Jenkins 초기 비밀번호 확인
```bash
docker exec -t jenkins /bin/bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"
# 결과로 출력되는 초기 비밀번호를 복사해놓는다.
```

### Jenkins 접속하기
```bash
1. snap install ngrok # ngrok 명령어 설치
2. ngrok config add-authtoken <Your AuthToken(ngrok)> # ngrok 사이트 가입 필요
3. cat /home/vagrant/.config/ngrok/ngrok.yml #ngrok 토큰 확인 명령어
# 참고로 ngrok Auth Token은 홈페이지에서 원할 때마다 Reset해서 새 것으로 바꿀 수 있다.
4. 웹 브라우저에서 192.168.10.14(==실행하는 vagrant 머신의 IP):8080 검색하거나,
ngrok http 8080 명령을 입력 후에 나오는 링크를 클릭해서 이동하기
```

### 복사했던 초기 비밀번호를 입력
```bash
docker exec -t jenkins /bin/bash -c "cat /var/jenkins_home/secrets/initialAdminPassword" #초기 젠킨스 비밀번호 확인 명령어
# 여기서 나오는 결과물을 Jenkins에다 입력을 하자
```

### install suggested plugins 클릭

### Getting Started 스크린이 뜨고 기다리면 된다.