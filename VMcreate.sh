#!/bin/bash
echo "What would you like to name the VM?"

read VMname

echo "Enter an IP for the VM:"

read IP

sudo mkdir -p /var/lib/libvirt/images/$VMname/mytemplates/libvirt

sudo cp /etc/vmbuilder/libvirt/* /var/lib/libvirt/images/$VMname/mytemplates/libvirt/

sudo echo -e "root 10000\nswap 4000" > /var/lib/libvirt/images/$VMname/vmbuilder.partition

sudo echo "# This script will run the first time the virtual machine boots
# It is ran as root.

# Expire the user account
passwd -e evan

# Install openssh-server
apt-get update
apt-get install -qqy --force-yes openssh-server" > /var/lib/libvirt/images/$VMname/boot.sh

cd /var/lib/libvirt/images/$VMname/
sudo vmbuilder kvm ubuntu --suite=precise --flavour=virtual --arch=amd64 -o --libvirt=qemu:///system --ip=$IP --gw=192.168.0.1 --part=vmbuilder.partition --templates=mytemplates --user=user --name=User --pass=changeme --addpkg=vim-nox --addpkg=unattended-upgrades --addpkg=acpid --firstboot=/var/lib/libvirt/images/$VMname/boot.sh --mem=512 --hostname=$VMname --bridge=br0
