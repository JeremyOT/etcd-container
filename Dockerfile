FROM ubuntu:14.04
MAINTAINER jeremyot@gmail.com

RUN apt-get update && apt-get install build-essential curl git -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz > /tmp/go1.3.linux-amd64.tar.gz && tar -C /usr/local -xzf /tmp/go1.3.linux-amd64.tar.gz && rm /tmp/go1.3.linux-amd64.tar.gz
ADD https://github.com/coreos/etcd/archive/master.tar.gz /tmp/master.tar.gz
RUN tar -C /tmp -xzf /tmp/master.tar.gz && mv /tmp/etcd-master /opt/etcd && rm -r /tmp/*
RUN cd /opt/etcd; export GOROOT=/usr/local/go; export GOPATH=/var/go; export PATH=$PATH:$GOROOT/bin; ./build
WORKDIR /var/etcd
VOLUME ["/var/etcd"]
EXPOSE 4001 7001
ENTRYPOINT ["/opt/etcd/bin/etcd"]
