# syntax=docker/dockerfile:1.2
ENV DEBIAN_FRONTEND=noninteractive
RUN useradd -m -s /bin/bash user -u 501 -g 20
RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    software-properties-common \
    tzdata


