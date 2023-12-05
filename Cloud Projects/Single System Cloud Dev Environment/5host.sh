#! /bin/bash

yum -y install epel-release
yum -y install cloudstack-agent

sed -i 's/#vnc_listen = "0.0.0.0"/vnc_listen = "0.0.0.0"/' /etc/libvirt/qemu.conf

sed -i 's/#listen_tls = 0/listen_tls = 0/' /etc/libvirt/libvirtd.conf
sed -i 's/#listen_tcp = 1/listen_tcp = 1/' /etc/libvirt/libvirtd.conf
sed -i 's/#tcp_port = "16509"/tcp_port = "16509"/' /etc/libvirt/libvirtd.conf
sed -i 's/#auth_tcp = "sasl"/auth_tcp = "none"/' /etc/libvirt/libvirtd.conf
sed -i 's/#mdns_adv = 1/mdns_adv = 0/' /etc/libvirt/libvirtd.conf

sed -i 's/#LIBVIRTD_ARGS="--listen"/LIBVIRTD_ARGS="--listen"/' /etc/sysconfig/libvirtd

systemctl restart libvirtd

echo "guest.cpu.mode=host-passthrough" >> /etc/cloudstack/agent/agent.properties
echo "guest.cpu.features=vmx" >> /etc/cloudstack/agent/agent.properties