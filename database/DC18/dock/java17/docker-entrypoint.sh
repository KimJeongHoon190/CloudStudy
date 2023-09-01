#!/bin/bash

USERNAME=${USERNAME=-user}
PASSWORD=${PASSWORD=-user}
GIT_URL=${GIT_URL}

useradd -s /bin/bash -m $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

su $USERNAME -c "cd ~/ && git clone $GIT_URL"

/usr/sbin/sshd -D -e