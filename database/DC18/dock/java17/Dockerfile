FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

# dos2unix 설치
RUN apt-get update -y && \
    apt-get install -y dos2unix && \
    apt-get clean

# Git, OpenJDK, SSH 설치 및 sshd 설정
RUN apt-get update -y && \
    apt-get install -y openjdk-17-jdk git ssh && \
    apt-get clean && \
    mkdir -p /run/sshd && \
    sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config

# docker-entrypoint.sh 복사
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# dos2unix를 사용하여 스크립트의 줄 바꿈 문자 변경
RUN dos2unix /usr/local/bin/docker-entrypoint.sh

# ENTRYPOINT 설정
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
