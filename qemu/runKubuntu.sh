#!/usr/bin/env bash
#

# Run with shared folder from the host
qemu-system-x86_64 -enable-kvm -boot menu=on \
    -drive file=./Kubuntu.img,if=virtio \
    -fsdev local,security_model=passthrough,id=fsdev0,path=./shared \
    -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare \
    -m 4G -cpu host -smp 4 -vga virtio -display sdl,gl=on \

