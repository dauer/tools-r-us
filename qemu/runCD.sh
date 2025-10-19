#!/usr/bin/env bash
#

# Run with data ISO (CDRom) mounted
qemu-system-x86_64 -enable-kvm -cdrom ./cd.iso -boot menu=on \
    -drive file=./disk.qcow \
    -m 4G -cpu host -smp 4 -vga virtio -display sdl,gl=on \
