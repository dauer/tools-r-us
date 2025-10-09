#!/usr/bin/env bash
#

# Create a 15Gb disc image to install to
if [ ! -f Kubuntu.img ]; then
    qemu-img create -f qcow2 Kubuntu.img 15G
fi


# Install from Kubuntu ISO
qemu-system-x86_64 -enable-kvm -cdrom ./kubuntu-25.04-desktop-amd64.iso -boot menu=on \
    -drive file=./Kubuntu.img \
    -m 4G -cpu host -smp 4 -vga virtio -display sdl,gl=on \

