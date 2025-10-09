# QEmu examples

These scripts create and runs a virtualized Kubuntu using QEmu

## Introduction

The examples uses Kubuntu from an ISO file `kubuntu-25.04-desktop-amd64.iso`
downloaded from [kubuntu.org](https://kubuntu.org/getkubuntu/).

[Slide](https://dauer.github.io/qemu-lightning-talk/) from a lightning talk I
gave at my local [Linux User Group](http://flug.dk/).

## The scripts

### Install Kubuntu

The script `./installKubuntu.sh` creates an image file we can install Kubuntu on
and start the installation process.

### Run Kubuntu with shared folder

The script `./runKubuntu.sh` starts our virtualized Kubuntu image with the folder
`./shared` mountet from the host into the virtual machine.

### Run Kubuntu with a CDRom mountet

Another quick way to get access to files from the host machine in the guest OS
is to mount a CDRom. You can use the script `./runKubuntuCD.sh` for that.

The script requires an ISO file named `./cd.iso` to exist, this can be created
with the `./mkISO.sh` script. That script builds a Joliet CD image containing the
files in the `./shared/` folder

## Todo

I can't get copy/paste between the host and the guest OS to work - I wonder if that is an Wayland issue...
