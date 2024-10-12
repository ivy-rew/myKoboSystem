#!/bin/bash

# https://superuser.com/questions/1086133/vnc-server-configuration-for-multi-monitor-support


w=1680
h=1264
fps=30

newMonitor(){}
  modeline=$(gtf $wx $h $fps)
  echo $modeline
}

enable(){
  virtual="HDMI-2"
  xrandr --newmode "1680x1264_30.00"  83.33  1680 1744 1920 2160  1264 1265 1268 1286  -HSync +Vsync
  xrandr --addmode HDMI-2 1680x1264_30.00
  xrandr --output HDMI-2 --mode 1680x1264_30.00 --right-of eDP-1 
}

vncHost(){
  # primary desk with
  offset=1920
  x11vnc -clip 1680x1264+$offset+0
}
