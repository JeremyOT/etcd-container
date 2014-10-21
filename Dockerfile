FROM busybox:ubuntu-14.04
MAINTAINER jeremyot@gmail.com

RUN cd /tmp; \
    wget -O - http://www.magicermine.com/demos/curl/curl/curl-7.30.0.ermine.tar.bz2 | bunzip2 -c - | tar -xf -; \
    /tmp/curl-7.30.0.ermine/curl.ermine -kL http://github.com/coreos/etcd/releases/download/v0.4.6/etcd-v0.4.6-linux-amd64.tar.gz > /tmp/etcd.tar.gz; \
    tar -xvzf /tmp/etcd.tar.gz; \
    mkdir -p /usr/local; \
    mv /tmp/etcd-v0.4.6-linux-amd64 /usr/local/etcd; \
    rm -rf /tmp/*;

WORKDIR /var/etcd
VOLUME ["/var/etcd"]
EXPOSE 4001 7001
ENTRYPOINT ["/usr/local/etcd/etcd"]
