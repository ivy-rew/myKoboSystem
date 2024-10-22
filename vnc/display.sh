#!/bin/bash

# https://superuser.com/questions/1086133/vnc-server-configuration-for-multi-monitor-support

. ./env.sh

fps=30

newMonitor(){
  gtf $w $h $fps | grep -o -E '".*'
}

einkOutput(){
  mode="${w}x${h}_${fps}.00"
  xrandr --newmode $(newMonitor)
  echo "adding mode"
  xrandr --addmode $virtual "\"${mode}\""
  echo "output to ${virtual}"
  xrandr --output $virtual --mode "\"${mode}\"" --right-of eDP
}

vncHost(){
  x11vnc -clip "${w}x${h}+${offset}+0"
}
