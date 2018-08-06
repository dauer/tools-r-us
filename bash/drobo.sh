#!/bin/sh
#
# sudo apt-get install samba
# sudo apt-get install cifs-utils
#

sudo mount -t cifs -o vers=1.0,sec=ntlm,uid=1000 //192.168.0.8/Drobo /media/drobo
