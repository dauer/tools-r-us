#!/usr/bin/env bash
#

# Create a 15Gb disk image to install to
if [ ! -f disk.qcow ]; then
  read -p "Create sidk image (y/n)? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      qemu-img create -f qcow2 disk.qcow 15G
  fi
fi

# Boot and install from ISO
qemu-system-x86_64 -enable-kvm -cdrom ${QEMU_BOOT_ISO} -boot menu=on \
    -drive file=./disk.qcow \
    -m 4G -cpu host -smp 4 -vga virtio -display sdl,gl=on \
