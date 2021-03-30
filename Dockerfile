ARG cuda_version=10.0
ARG cudnn_version=7
ARG PORT=35367
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel
LABEL maintainer="kiyou <46545721+kiyou@users.noreply.github.com>"
ENV DEBIAN_FRONTEND noninteractive

# install apt packages
RUN sed -i.bak -e "s%http://\(archive\|security\).ubuntu.com/ubuntu/%http://ftp.riken.jp/Linux/ubuntu/%g" /etc/apt/sources.list
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends \
        git \
        gnuplot \
        golang-go \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV GOPATH /go
RUN mkdir -p $GOPATH/src/github.com/mumax/3 && \
    mkdir -p $GOPATH/bin
ENV PATH $PATH:$GOPATH/bin

WORKDIR $GOPATH
EXPOSE $PORT
