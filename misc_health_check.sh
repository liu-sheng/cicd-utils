#!/bin/bash
# This script should be run in openlab ci misc server
function check_service_status {
    if service $1 status > /dev/null; then
        echo "Service $1 is running :)"
    else
        echo "Service $1 is not running!"
        exit 1
    fi
}

for srv in "mysql" "grafana-server" "statsd" "apache2"
do
    check_service_status $srv
done

for port in 7002 4730 9000 11211 8080 2003 2004 8126 2181 21711 3000
do
    if nc -z localhost $port; then
       echo "Port $port is in listen state :)"
    else
       echo "Port $port is not in listen state, please check!"
       exit 1
    fi
done

if a2query -s zuul-web -q; then
    echo "Apache site zuul-web is OK :)"
else
    echo "Apache site zuul-web is down!"
fi
if ps -ef |grep -q zuul-web; then
    echo "Service zuul-web is running :)"
else
    echo "Service zuul-web is not running!"
fi
