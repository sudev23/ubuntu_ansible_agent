FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN ssh-keygen -A

RUN useradd -m hero && \
    echo "hero:hero123" | chpasswd && \
    adduser hero sudo

RUN mkdir /var/run/sshd

RUN mkdir -p /home/hero/.ssh && \
    chmod 700 /home/hero/.ssh && \
    touch /home/hero/.ssh/authorized_keys && \
    chmod 600 /home/hero/.ssh/authorized_keys && \
    chown -R hero:hero /home/hero/.ssh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
