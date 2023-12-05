#! /bin/bash

theIP=172.16.10.2
theGW=172.16.10.1
theNM=255.255.255.0
theHOST=cloudstackmgr1

yum install bridge-utils net-tools -y

echo "DEVICE=cloudbr0" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "TYPE=Bridge" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "BOOTPROTO=static" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "IPV6INIT=no" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "IPV6_AUTOCONF=no" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "DELAY=5" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "IPADDR=$theIP" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "GATEWAY=$theGW" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "NETMASK=$theNM" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "DNS1=8.8.8.8" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "DNS2=8.8.4.4" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "STP=yes" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "USERCTL=no" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0
echo "NM_CONTROLLED=no" >> /etc/sysconfig/network-scripts/ifcfg-cloudbr0

echo "DEFROUTE=yes" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "NAME=eth0" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "BRIDGE=cloudbr0" >> /etc/sysconfig/network-scripts/ifcfg-eth0

sed -i 's/BOOTPROTO=static/BOOTPROTO=none/' /etc/sysconfig/network-scripts/ifcfg-eth0

sudo systemctl restart network