#!/bin/bash
export BROWSER=firefox-beta-bin
#export DE=gnome
export EDITOR=nano

unclutter &
xmodmap /home/kennae/.xmodmaprc &
synclient TapAndDragGesture=0 &
synclient MaxTapTime=0 &
udiskie &
 
#Dbus fix
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

#exec gnome-session
exec i3

