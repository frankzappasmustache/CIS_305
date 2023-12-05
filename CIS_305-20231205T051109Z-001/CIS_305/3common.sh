#! /bin/bash

setenforce 0

sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

yum -y install ntp

systemctl enable ntpd

systemctl start ntpd

# systemctl stop firewalld

# systemctl disable firewalld

cat <<'EOF' > /etc/yum.repos.d/cloudstack.repo
[cloudstack]
name=cloudstack
baseurl=http://download.cloudstack.org/centos/$releasever/4.18/
enabled=1
gpgcheck=0
EOF