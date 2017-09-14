#!/bin/sh
# not used in this container, but an example of a script to put into the backend container to adjust the default gateway
# pass an argument of the host you'd like to adjust the gateway to, if it responds to pings the gateway will be adjusted
# using a user-defined docker network, you can use the name of the container to do a dns resolution 


host=$1
if [[ ! $host == "" ]] ; then
  defaultGW=`route -n | grep ^0\.0\.0\.0 | awk '{ print $2 }'`
  hostIP=`ping $host -c1 | grep $host -m1 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
  #ip route add 10.0.0.0/8 via $defaultGW
  if [[ $? -eq 0 ]] ; then
    if [[ `route -n | grep '^0\.0\.0\.0' | grep $hostIP | wc -l` -eq 0 ]] ; then
          ip route del default
      ip route add default via $hostIP
      echo "default route updated to point to $1"
        else
          echo default route already changed > /dev/null
        fi
  else
    echo "host ($host) didn't respond to pings"
  fi
else
  echo "please pass a host to have the gateway updated"
fi
