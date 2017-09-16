#!/bin/bash

#Variables
#-----------------------------------#

cd ~

#PREFLIGHT CHECKLIST
#-----------------------------------#
# Install epel
yum install -y epel-release

# Add ceph repo
cat > /etc/yum.repos.d/ceph.repo <<EOF
[ceph-noarch]
name=Ceph noarch packages
baseurl=https://download.ceph.com/rpm/el7/noarch
enabled=1
gpgcheck=1
type=rpm-md
gpgkey=https://download.ceph.com/keys/release.asc
EOF

#yum update

yum install  -y chrony 

yum install -y openssh-server

yum install -y ceph-deploy

#RUN SERVICES
#-----------------------------------#
systemctl start chronyd 

systemctl enable chronyd 

systemctl start sshd

#CREATE USER & KEYS
#-----------------------------------#
# create user 'ceph'
useradd -d /home/ceph -m ceph

echo "ceph:ceph" | chpasswd

echo "ceph ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ceph

sudo chmod 0440 /etc/sudoers.d/ceph

# create private keys
mkdir -p /home/ceph/.ssh

ssh-keygen -t rsa -b 4096 -C "Heyho" -P "" -f "/home/ceph/.ssh/id_rsa" -q


#FIREWALL & SELINUX SETTINGS
#-----------------------------------#
systemctl stop firewalld

systemctl disable firewalld

setenforce 0

sed -i --follow-symlinks 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux && cat /etc/sysconfig/selinux

#EXTRA SETTINGS
#-----------------------------------#
yum install -y yum-plugin-priorities 

