#!/bin/sh

sudo mount -t cifs -o sec=ntlm,uid=1000 //192.168.1.11/Drobo /media/drobo
