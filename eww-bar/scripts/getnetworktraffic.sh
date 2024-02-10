#!/bin/bash

interface=${1:- $( ls -1 /sys/class/net | head -1 )}
echo $interface

if [ -z "$1" ]; then
        echo
        echo usage: $0 network-interface
        echo
        echo e.g. $0 eth0
        echo
        exit
fi

while true
do
        R1=`cat /sys/class/net/$interface/statistics/rx_bytes`
        T1=`cat /sys/class/net/$interface/statistics/tx_bytes`
        sleep 1
        R2=`cat /sys/class/net/$interface/statistics/rx_bytes`
        T2=`cat /sys/class/net/$interface/statistics/tx_bytes`
        TBPS=`expr $T2 - $T1`
        RBPS=`expr $R2 - $R1`
        TKBPS=`expr $TBPS / 1024`
        RKBPS=`expr $RBPS / 1024`
        echo "tx $1: $TKBPS kB/s rx $1: $RKBPS kB/s"
done
