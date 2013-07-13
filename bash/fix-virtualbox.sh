#!/usr/bin/env bash

# Every time I get a kernel upgrade Virtualbox breaks...
# This script fixes that problem

sudo apt-get install linux-headers-`uname -r` 
sudo apt-get remove virtualbox-dkms
sudo apt-get install virtualbox-dkms
