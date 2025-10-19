# QEmu examples

These scripts create and runs a virtual machines (Linux, Windows, Haiku, ...) using [QEmu](https://www.qemu.org/)

## Introduction

The examples uses Kubuntu from an ISO file `kubuntu-25.04-desktop-amd64.iso`
downloaded from [kubuntu.org](https://kubuntu.org/getkubuntu/).

[Slides](https://dauer.github.io/qemu-lightning-talk/) from a lightning talk I
gave at my local [Linux User Group](http://flug.dk/).

## The scripts

### Install

Specify the ISO image you want to install from by setting the environment variable `QEMU_BOOT_ISO`

In this example we install Kubuntu:

    export QEMU_BOOT_ISO="./iso/kubuntu-25.04-desktop-amd64.iso"

If you want to run [Haiku](https://www.haiku-os.org/):

    export QEMU_BOOT_ISO="./iso/haiku-r1beta5-x86_64-anyboot.iso"

Running the script `./install.sh` now creates an image file we can install Kubuntu on
and start the installation process.

### Run Kubuntu with shared folder

The script `./runDisk.sh` starts our virtualized Kubuntu image with the folder
`./shared` mounted from the host into the virtual machine.

To access the shared folder from the guest, run the `guestMount.sh` script
(from inside the Linux guest OS).

### Run the virtual machine with a CD-Rom mounted

Another quick way to get access to files from the host machine in the guest OS
is to mount a CD-Rom. You can use the script `./runCD.sh` for that.

The script requires an ISO file named `./cd.iso` to exist, this can be created
with the `./mkISO.sh` script. That script builds a [Joliet](https://en.wikipedia.org/wiki/ISO_9660#Joliet)
CD image containing the files in the `./shared/` folder.

## Todo

I can't get copy/paste between the host and the guest OS to work - I wonder if that is a Wayland issue...
