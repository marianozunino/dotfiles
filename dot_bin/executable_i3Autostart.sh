#!/bin/sh
########################
xrdb -merge ~/.Xresources
#compton &
lxsession &
dunst &
flameshot &
polybar --reload top &
blueman-applet &
setxkbmap -layout us -variant altgr-intl -option caps:escape -option escape:none

i3-msg "workspace 1"
#disable touchpad in thinky
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0
nm-applet &
locker.sh &
insync start
greenclip daemon &
