FROM ubuntu:20.04

RUN apt-get update && apt-get install -y curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/list/*

RUN mkdir /home/noc

ENV USER noc
ENV SHELL /bin/bash
ENV LOGNAME noc1

CMD ["bash"]
