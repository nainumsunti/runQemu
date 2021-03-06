#!/bin/bash
numsmp="4"
memsize="4G"
imgloc=${HOME}/"runQemu"/"runQemu-imgs"
imgfile="Compute1-raw.img"
exeloc="/usr/local/bin"
CPU_LIST="0-7"
TASKSET="taskset -c ${CPU_LIST}"
#
sudo ${TASKSET} ${exeloc}/qemu-system-x86_64 -enable-kvm -cpu host -smp ${numsmp} \
     -m ${memsize} -L pc-bios -drive file=${imgloc}/${imgfile},format=raw \
     -boot c -vnc :99 \
     -netdev type=tap,script=${HOME}/runQemu/runQemu-etc/ovs-manage-ifup,downscript=${HOME}/runQemu/runQemu-etc/ovs-manage-ifdown,id=hostnet10 \
     -device virtio-net-pci,romfile=,netdev=hostnet10,mac=00:54:99:25:32:17 \
     -netdev type=tap,script=${HOME}/runQemu/runQemu-etc/ovs-data-ifup,downscript=${HOME}/runQemu/runQemu-etc/ovs-data-ifdown,id=hostnet11 \
     -device virtio-net-pci,romfile=,netdev=hostnet11,mac=00:54:99:25:32:18 \
     -netdev type=tap,script=${HOME}/runQemu/runQemu-etc/ovs-vlan-ifup,downscript=${HOME}/runQemu/runQemu-etc/ovs-vlan-ifdown,id=hostnet12 \
     -device virtio-net-pci,romfile=,netdev=hostnet12,mac=00:54:99:25:32:19 \
     -netdev type=tap,script=${HOME}/runQemu/runQemu-etc/ovs-manage-ifup,downscript=${HOME}/runQemu/runQemu-etc/ovs-manage-ifdown,id=hostnet13 \
     -device virtio-net-pci,romfile=,netdev=hostnet13,mac=00:54:99:25:32:16 \
     -qmp tcp:localhost:9447,server,nowait \
     -monitor tcp::9669,server,nowait \
     -localtime 
