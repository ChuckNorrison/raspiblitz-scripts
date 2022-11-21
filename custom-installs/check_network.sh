#!/bin/bash

# tweak ip to check ping here
gatewayip="10.8.0.1"

# PID file check
pidfile=/var/run/check_network.sh.pid
if [ -f $pidfile ]; then
    echo "script is already running"
    exit
fi
# Ensure PID file is removed on program exit.
trap "rm -f -- '$pidfile'" EXIT
# Create a file with current PID to indicate that process is running.
echo $$ > "$pidfile"

function repairCon() {
  /usr/sbin/dhclient -r; /usr/sbin/dhclient > /dev/null
  sleep 15
  systemctl restart openvpn@client
  sleep 15
  systemctl restart nginx
  echo "`date`: Connectivity repaired... hopefully"    
}

ping -q -c 4 $gatewayip > /dev/null
if [ $? -eq 0 ]; then
  echo "`date`: Connectivity check successful"
else
  echo "`date`: Connectivity check failed"
  count=1
  count_max=10
  while ! ping -q -c 4 $gatewayip > /dev/null;
  do
    echo "`date`: retry $count/$count_max"
    sleep 10
    if [ $count = $count_max ]; then
      repairCon
      exit 1
    fi
    count=`expr $count + 1`
  done
  echo "`date`: Connectivity check retry successful"
fi
