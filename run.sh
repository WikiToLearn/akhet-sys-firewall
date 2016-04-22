#!/bin/bash
iptables -t filter -A OUTPUT -m state ! --state NEW -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT
iptables -t filter -A OUTPUT -m owner --uid-owner root -j ACCEPT
iptables -t filter -A OUTPUT -m owner --gid-owner root -j ACCEPT

[[ "$blacklistdest" != "" ]] && [[ "$blacklistdest" != "None" ]] && for host in $blacklistdest ; do
 iptables -t filter -A OUTPUT -d $host -j REJECT
done
[[ "$blacklistport" != "" ]] && [[ "$blacklistport" != "None" ]] && for port in $blacklistport ; do
 proto="tcp"
 echo $port | grep ":" &> /dev/null
 if [[ $? -eq 0 ]] ; then
  proto=$(echo $port | awk -F":" '{ print $2 }')
  port=$(echo $port | awk -F":" '{ print $1 }')
 fi
 iptables -t filter -A OUTPUT -p $proto --dport $port -j REJECT
done
[[ "$allowddest" != "" ]] && [[ "$allowddest" != "None" ]] && for host in $allowddest ; do
 iptables -t filter -A OUTPUT -d $host -j ACCEPT
done
[[ "$allowdport" != "" ]] && [[ "$allowdport" != "None" ]] && for port in $allowdport ; do
 proto="tcp"
 echo $port | grep ":" &> /dev/null
 if [[ $? -eq 0 ]] ; then
  proto=$(echo $port | awk -F":" '{ print $2 }')
  port=$(echo $port | awk -F":" '{ print $1 }')
 fi
 iptables -t filter -A OUTPUT -p $proto --dport $port -j ACCEPT
done

if [[ "$defaultrule" != "ACCEPT" ]] ; then
 iptables -t filter -A OUTPUT -j REJECT
else
 iptables -t filter -A OUTPUT -j ACCEPT
fi
while true ; do
 netstat -netupa | grep 5900 &> /dev/null
 if [[ $? -ne 0 ]] ; then
  echo "Waiting x11vnc..."
else
  break
 fi
 sleep 1
done

while true ; do
 netstat -netupa | grep 5900 &> /dev/null
 if [[ $? -ne 0 ]] ; then
  echo "Exit now"
  exit
 fi
 sleep 1
done
