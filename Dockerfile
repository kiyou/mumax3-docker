ARG cuda_version=10.0
ARG PORT=35367
FROM nvidia/cuda:${cuda_version}-devel-ubuntu18.04
LABEL maintainer="kiyou <46545721+kiyou@users.noreply.github.com>"
ENV DEBIAN_FRONTEND noninteractive

# install apt packages
RUN apt-get -y update && \
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
