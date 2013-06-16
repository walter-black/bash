#!/bin/bash
echo "Which VM do you want to delete?"

read VMname

sudo virsh --connect qemu:///system undefine $VMname

rm -rf /var/lib/libvirt/images/$VMname
