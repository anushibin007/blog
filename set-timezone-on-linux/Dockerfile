FROM ubuntu:latest

RUN apt-get update -y && \
apt-get install --no-install-recommends -y tzdata && \
rm -rf /var/lib/apt/lists/*

CMD date
