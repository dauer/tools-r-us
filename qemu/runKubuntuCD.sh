#!/usr/bin/env bash
#

# Run with data ISO mountet
qemu-system-x86_64 -enable-kvm -cdrom ./cd.iso -boot menu=on \
    -drive file=./Kubuntu.img \
    -m 4G -cpu host -smp 4 -vga virtio -display sdl,gl=on \

