FROM maven:latest
RUN apt-get update && apt-get install -y git docker.io
