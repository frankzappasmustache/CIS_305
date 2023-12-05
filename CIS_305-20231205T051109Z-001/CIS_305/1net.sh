#! /bin/bash

theIP=172.16.10.2
theGW=172.16.10.1
theNM=255.255.255.0
theHOST=cloudstackmgr1

echo "IPADDR=$theIP" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "GATEWAY=$theGW" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "NETMASK=$theNM" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "DNS1=8.8.8.8" >> /etc/sysconfig/network-scripts/ifcfg-eth0

sed -i 's/BOOTPROTO=none'/BOOTPROTO=static/ /etc/sysconfig/network-scripts/ifcfg-eth0

echo "$theIP $theHOST" >> /etc/hosts

hostnamectl set-hostname $theHOST

sudo systemctl disable NetworkManager; sudo systemctl stop NetworkManager
sudo systemctl enable network
sudo systemctl restart network