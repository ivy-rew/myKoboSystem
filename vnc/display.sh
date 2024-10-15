#!/bin/bash

# https://superuser.com/questions/1086133/vnc-server-configuration-for-multi-monitor-support

# H20
#w=1680
#h=1264

#Eclipsa2E
w=1404
h=1872
fps=30

newMonitor(){
  modeline=$(gtf $w $h $fps)
  echo $modeline
}

enable(){
  virtual="HDMI-2"
  virtual="HDMI-A-0"
  #xrandr --newmode "$wx$h_$fps.00"  83.33  1680 1744 1920 2160  1264 1265 1268 1286  -HSync +Vsync
  mode="${w}x${h}_${fps}.00"
  xrandr --newmode "1408x1872_30.00"  106.93  1408 1488 1640 1872  1872 1873 1876 1904  -HSync +Vsync
  xrandr --addmode $virtual "${mode}"
  xrandr --output $virtual --mode "${mode}" --right-of eDP
}

vncHost(){
  # primary desk with
  offset=1920
  x11vnc -clip $wx$h+$offset+0
}
