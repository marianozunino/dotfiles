#!/bin/bash

bin=~/.bin/leapp
latest_version_url="https://api.github.com/repos/noovolari/leapp/releases/latest"

# Function to compare version numbers
function version_gt() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; }

# If leapp binary is not found or if there is a newer version, download it
if [ ! -f $bin ] || version_gt "$(curl -s $latest_version_url | grep -oP '"tag_name": "\K(.*)(?=")')" "$(basename $bin | grep -oP '\d+\.\d+\.\d+')"; then
	notify-send -u normal "⏬ Leapp" "Checking for updates..."
	url="https://asset.noovolari.com/latest/Leapp-appImage.zip"
	wget -q -O /tmp/leapp.AppImage "$url"
	unzip /tmp/leapp.AppImage -d /tmp
	mv /tmp/release/Leapp* $bin
	chmod +x $bin
fi

# Execute leapp
$bin -f -i $1 -o $2
