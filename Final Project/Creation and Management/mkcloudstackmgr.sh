#! /bin/bash

virt-install \
--virt-type=kvm \
--name cloudstackmgr \
--ram 13312 \
--vcpus=6 \
--cpu host \
--os-variant=centos7.0 \
--hvm \
--network network=nat1 \
--graphics vnc \
--disk /var/lib/libvirt/images/cloudstackmgr.qcow2 \
--boot=hd \
--noautoconsole