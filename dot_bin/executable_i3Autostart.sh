#!/bin/sh
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh
dunst &
waybar.sh &
blueman-applet &
nm-applet &
slack &

foot --server &
# wait for foot server to start
sleep 1;
footclient -a dropdown
