#!/bin/bash

# Nickel-Menu launcher
# https://www.mobileread.com/forums/showthread.php?t=329525

kobo=/media/${USER}/KOBOeReader

if [ ! -d "${kobo}" ]; then
  echo "KOBO not connected to USB under ${kobo}. "
  echo "Please connect KOBO or configure its location by setting the 'kobo' variable."
  exit  
fi

nickelInstall(){
  wget https://github.com/pgaskin/NickelMenu/releases/latest/download/KoboRoot.tgz
  cp -v KoboRoot.tgz "${kobo}/.kobo"
  echo "NickelMenu installed"
  echo "Eject Kobo from USB and wait for reboot"
}

nickelConfig(){
  confDir="${kobo}/.adds/nm"
  if [ ! -d "${confDir}" ]; then
    echo "missing nickel config dir ${confDir}. Is NickelMenu installed?"
  fi
  cp -v "${PWD}/nickelConfig/*" "$confDir"
}

nickelInstall()

# after reboot!
# nickelConfig()
