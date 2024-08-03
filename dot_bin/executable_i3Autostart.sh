#!/bin/sh
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh
dunst &
waybar.sh &
blueman-applet &
nm-applet &
slack &

wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
vesktop &

foot --server &
# wait for foot server to start
sleep 1
footclient -a dropdown
espanso service start --unmanaged

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
