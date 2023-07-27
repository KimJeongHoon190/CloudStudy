FROM hedgehoon/httpd:1.0

ENV REPO=static-web-template
ENV TAG_VERSION=1.1

RUN curl -LJO https://github.com/AnByoungHyun/${REPO}/archive/refs/tags/v${TAG_VERSION}.tar.gz
RUN tar -zxvf ${REPO}-${TAG_VERSION}.tar.gz
RUN mv ${REPO}-${TAG_VERSION}/* /usr/local/apache2/htdocs