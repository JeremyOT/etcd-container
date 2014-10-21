FROM debian:wheezy
MAINTAINER jeremyot@gmail.com

RUN apt-get update && apt-get install build-essential curl git -y; \
    curl https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz > /tmp/go1.3.linux-amd64.tar.gz && tar -C /usr/local -xzf /tmp/go1.3.linux-amd64.tar.gz; \
    curl -L https://github.com/coreos/etcd/archive/dcaa7f0a3778df66208d86bcfc0624709944b387.tar.gz > /tmp/etcd.tar.gz && tar -C /tmp -xzf /tmp/etcd.tar.gz && \
    mv /tmp/etcd-dcaa7f0a3778df66208d86bcfc0624709944b387 /opt/etcd; \
    cd /usr/local/etcd; export GOROOT=/usr/local/go; export GOPATH=/var/go; export PATH=$PATH:$GOROOT/bin; ./build; \
    mv /usr/local/etcd/bin/etcd /usr/local/bin/etcd; \
    rm -rf /usr/local/go; rm -rf /usr/local/etcd; \
    apt-get remove --purge build-essential curl git -y; \
    apt-get autoremove -y; apt-get clean; rm -rf /var/lib/apt/lists/*; rm -rf /tmp/* /var/tmp/*; rm -rf /usr/share; rm -rf /var/lib;
WORKDIR /var/etcd
VOLUME ["/var/etcd"]
EXPOSE 4001 7001
ENTRYPOINT ["/usr/local/bin/etcd"]
