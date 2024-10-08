#!/bin/bash

usbdev="usb0"
if [[ -z $(ip link | grep "usb0" ) ]]; then
  usbdev=$(ip link | grep 'enx[^ ]' | awk '{print $2}' | tr -d ':')
fi
echo $usbdev

usbIP(){
  sudo ip addr add 192.168.2.1 broadcast + dev $usbdev
  sudo ip route add 192.168.2.0/24 dev $usbdev
}

# enable SSH server in kordeader; with "passwordless" auth
# 
# only ecdsa works to connect: so generate one just for kobo
# ssh-keygen -t ecdsa 
# read its public key cat ~/.ssh/*.pub
# add it manually to: /mnt/onboard/.adds/koreader/settings/SSH/authorized_keys
# then remove SSH server open 'passwordless'


# https://www.mobileread.com/forums/showthread.php?t=353810

# https://www.yingtongli.me/blog/2018/07/30/kobo-telnet-usb.html

# tightvncserver :7 -geometry 1680x1264 -depth 24 -dpi 96

# einkvnc

# https://github.com/everydayanchovies/eink-vnc