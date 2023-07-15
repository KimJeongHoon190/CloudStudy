FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y nginx git
RUN git clone https://github.com/KimJeongHoon190/static-web-template.git
COPY nginx/sites-available/default /usr/share/nginx/html/
RUN cp -r static-web-template/* /var/www/html
CMD ["nginx","-g","daemon off;"]
EXPOSE 80
