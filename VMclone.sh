#!/bin/bash

echo "What VM would you like to clone?"

read VMname

echo "What would you like to name the new system?"

read NewName

mkdir -p /var/lib/libvirt/images/$NewName

virt-clone --connect=qemu:///system -o $VMname -n $NewName -f /var/lib/libvirt/images/$NewName/$NewName.gcow2
