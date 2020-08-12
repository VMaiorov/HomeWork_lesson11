FROM ubuntu:18.04
RUN apt update && apt install -y default-jdk maven git docker.io
