FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt_get update -y
RUN apt-get install -y openjdk-17-jdk
RUN apt-get install -y ssh
RUN apt_get clean
RUN sed -i \
 "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
 COPY docker-entrypoint.sh /usr/local/bin/

 RUN chmod +x /usr/local/bin/docker-entrypoint.sh
 ENTRYPOINT [ "docker-entrypoint.sh" ]