#!/bin/bash

usbdev=$(ip link | grep 'enx[^ ]' | awk '{print $2}' | tr -d ':')
echo $usbdev

# only ecdas works to connect!
# ssh-keygen -t ecdsa 

# https://www.mobileread.com/forums/showthread.php?t=353810

# https://www.yingtongli.me/blog/2018/07/30/kobo-telnet-usb.html

# tightvncserver :7 -geometry 1680x1264 -depth 24 -dpi 96

# einkvnc

# https://github.com/everydayanchovies/eink-vnc