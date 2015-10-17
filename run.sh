#!/bin/bash

# iptables -t filter -A OUTPUT -m state --state NEW -j ACCEPT
# iptables -t filter -A OUTPUT -p udp -j DROP
# iptables -t filter -A OUTPUT -p icmp -j DROP

sleep 2

while true ; do
 netstat -netupa | grep 5900 &> /dev/null
 if [[ $? -ne 0 ]] ; then
  echo "Exit now"
  exit
 fi
 sleep 1
done
