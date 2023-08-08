## Jenkins 설치 및 사용법

### 도커 로그인
```bash
docker login -u hedgehoon --password-stdin < /vagrant/env/docker_token
```

### Jenkins 실행하기
```bash
docker run -it -d -p 8080:8080 --name jenkins jenkins/jenkins:2.387.2-lts
# 1. docker volume create jenkins-volume
# 2. docker volume ls
# 3. docker run -it -d -p 8080:8080 --restart=always --name jenkins -v jenkins-volume:/var/jenkins_home/ -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker jenkins/jenkins:2.387.2-lts 
# 도커 볼륨을 사용해서 진행 사항을 저장하고 언제나 자동으로 다시 시작하게 하려면 위의 주석 처리한 명령어 세 개를 제일 처음 명령어 대신 쓴다.
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

### 접속하기
```bash
웹 브라우저에서 192.168.10.14(==실행하는 vagrant 머신의 IP):8080 검색하거나
ngrok http 8080 명령을 입력 후에 나오는 링크를 클릭해서 이동하기
```

### 복사했던 초기 비밀번호를 붙여넣고 엔터를 누르자

### install suggested plugins 선택

### Getting Started 스크린이 뜨고 기다리면 된다.