FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y \
      curl \
      python-dev

ARG my_ver=1.0      

WORKDIR /root
COPY hello.py .
ENV my_ver $my_ver

CMD ["python", "hello.py", "guest"]