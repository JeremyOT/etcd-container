FROM busybox:ubuntu-14.04
MAINTAINER jeremyot@gmail.com

RUN cd /tmp; \
    wget -O - http://www.magicermine.com/demos/curl/curl/curl-7.30.0.ermine.tar.bz2 | bunzip2 -c - | tar -xf -; \
    /tmp/curl-7.30.0.ermine/curl.ermine -kL http://github.com/coreos/etcd/releases/download/v3.0.8/etcd-v3.0.8-linux-amd64.tar.gz > /tmp/etcd.tar.gz; \
    tar -xvzf /tmp/etcd.tar.gz; \
    mkdir -p /usr/local; \
    mv /tmp/etcd-v3.0.8-linux-amd64 /usr/local/etcd; \
    rm -rf /tmp/*;
ADD address /usr/bin/address
ADD run.sh /usr/bin/run.sh
WORKDIR /var/etcd
VOLUME ["/var/etcd"]
EXPOSE 2379 2380 4001 7001
ENTRYPOINT ["/usr/bin/run.sh"]
