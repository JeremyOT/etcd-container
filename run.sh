#!/bin/sh

case $1 in
  auto)
    ARGS=`echo ${@} | awk '{for(i=2;i<=NF;++i)print $i}'`
    ADDRESS=`/usr/bin/address`
    exec /usr/local/etcd/etcd \
      --listen-client-urls="http://0.0.0.0:2379,http://0.0.0.0:4001" \
      --advertise-client-urls="http://$ADDRESS:2379,http://$ADDRESS:4001" \
      ${ARGS}
    ;;
  auto4)
    ARGS=`echo ${@} | awk '{for(i=2;i<=NF;++i)print $i}'`
    ADDRESS=`/usr/bin/address -4`
    exec /usr/local/etcd/etcd \
      --listen-client-urls="http://0.0.0.0:2379,http://0.0.0.0:4001" \
      --advertise-client-urls="http://$ADDRESS:2379,http://$ADDRESS:4001" \
      ${ARGS}
    ;;
  *)
    exec /usr/local/etcd/etcd ${@}
esac
