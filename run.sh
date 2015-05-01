#!/bin/bash

case $1 in
  auto)
    ARGS="${@:2}"
    ADDRESS=`/usr/bin/address`
    /usr/local/etcd/etcd \
      --listen-client-urls="http://0.0.0.0:2379,http://0.0.0.0:4001" \
      --advertise-client-urls="http://$ADDRESS:2379,http://$ADDRESS:4001" \
      --listen-peer-urls="http://0.0.0.0:2380,http://0.0.0.0:7001" \
      --initial-advertise-peer-urls="http://$ADDRESS:2380,http://$ADDRESS:7001" \
      "${ARGS[@]}"
    ;;
  auto4)
    ARGS="${@:2}"
    ADDRESS=`/usr/bin/address -4`
    /usr/local/etcd/etcd \
      --listen-client-urls="http://0.0.0.0:2379,http://0.0.0.0:4001" \
      --advertise-client-urls="http://$ADDRESS:2379,http://$ADDRESS:4001" \
      --listen-peer-urls="http://0.0.0.0:2380,http://0.0.0.0:7001" \
      --initial-advertise-peer-urls="http://$ADDRESS:2380,http://$ADDRESS:7001" \
      "${ARGS[@]}"
    ;;
  *)
    ARGS="${@:1}"
    /usr/local/etcd/etcd "${ARGS[@]}"
esac
