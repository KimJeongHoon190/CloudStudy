FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y apache2 git
RUN git clone https://github.com/KimJeongHoon190/static-web-template.git
RUN cp -r static-web-template/* /var/www/html
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
EXPOSE 80
