#!/bin/bash

for pid in `ps -ef |grep /usr/local/bin/nodepool-builder |grep -v grep | awk '{print $2}'`
do
    kill -9 $pid
done
for pid in `ps -ef |grep /usr/local/bin/nodepool-launcher |grep -v grep | awk '{print $2}'`
do
    kill -9 $pid
done
sleep 2
nohup /usr/bin/python3 /usr/local/bin/nodepool-builder -d -l /etc/nodepool/builder-logging.conf -c /etc/nodepool/nodepool.yaml > /dev/null 2>&1 & 
nohup /usr/bin/python3 /usr/local/bin/nodepool-launcher -d -l /etc/nodepool/launcher-logging.conf -c /etc/nodepool/nodepool.yaml > /dev/null 2>&1 &
