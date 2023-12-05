#! /bin/bash

yum -y install nfs-utils

sed -i 's/#Domain = local.domain.edu/Domain = wcc.edu/' /etc/idmapd.conf

cat <<'EOF' > /etc/exports
/export/secondary *(rw,async,no_root_squash,no_subtree_check)
/export/primary *(rw,async,no_root_squash,no_subtree_check)
EOF

mkdir -p /export/primary
mkdir /export/secondary

sed -i 's/#LOCKD_TCPPORT=32803/LOCKD_TCPPORT=32803/' /etc/sysconfig/nfs
sed -i 's/#LOCKD_UDPPORT=32769/LOCKD_UDPPORT=32769/' /etc/sysconfig/nfs
sed -i 's/#MOUNTD_PORT=892/MOUNTD_PORT=892/' /etc/sysconfig/nfs
sed -i 's/#STATD_PORT=662/STATD_PORT=662/' /etc/sysconfig/nfs
sed -i 's/#STATD_OUTGOING_PORT=2020/STATD_OUTGOING_PORT=2020/' /etc/sysconfig/nfs

echo "RQUOTAD_PORT=875" >> /etc/sysconfig/nfs

systemctl enable rpcbind
systemctl enable nfs
systemctl start rpcbind
systemctl start nfs

yum -y install wget
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum -y install mysql-server

sed -i '/\[mysqld\]/a
server-id=source-01\innodb_rollback_on_timeout=1\ninnodb_lock_wait_timeout=600\nmax_connectio
ns=350\nlog-bin=mysql-bin\nbinlog-format = "ROW"' /etc/my.cnf

systemctl enable mysqld
systemctl start mysqld
yum -y install mysql-connector-python
yum -y install cloudstack-management
alternatives --config java
cloudstack-setup-databases cloud:password@localhost --deploy-as=root
cloudstack-setup-management
/usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt -m /export/secondary -u http://download.cloudstack.org/systemvm/4.18/systemvmtemplate-4.18.1-kvm.qcow2.bz2 -h kvm -F