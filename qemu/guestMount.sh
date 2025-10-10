#!/usr/bin/env bash
#
# Mount the shared folder from the guest

sudo mount -t 9p -o trans=virtio,version=9p2000.L hostshare /tmp/hostfiles/
