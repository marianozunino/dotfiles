#!/bin/sh
########################
xrdb -merge ~/.Xresources
#compton &
lxsession &
dunst &
flameshot &
polybar --reload top &
blueman-applet &

setxkbmap -layout 'us(altgr-intl),us(dvp)' -option caps:escape -option escape:none -option grp:alt_shift_toggle

i3-msg "workspace 1"
#disable touchpad in thinky
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0
nm-applet &
locker.sh &
insync start
greenclip daemon &

# noisetorch -i -s "echoCancel_source"
# pacmd set-default-source nui_mic_remap
easyeffects --gapplication-service &
sudo quadcastrgb solid &
