FROM nginx:1.25.1

ENV REPO=static-web-template
ENV TAG_VERSION=2.0

RUN curl -LJO https://github.com/KimJeongHoon190/${REPO}/archive/refs/tags/v${TAG_VERSION}.tar.gz
RUN tar -zxvf ${REPO}-${TAG_VERSION}.tar.gz
RUN mv ${REPO}-${TAG_VERSION} /usr/share/nginx/html