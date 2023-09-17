#!/bin/bash

bin=~/.bin/redis

# set current working directory to ~/.bin
cd ~/.bin

if [ ! -f $bin ]; then
  notify-send -u normal "⏬ Redis Desktop Manager" "Downloading..."
  filename=$(curl -s https://api.github.com/repos/qishibo/AnotherRedisDesktopManager/releases/latest | jq -r '.assets[].name' | grep "AppImage")
  fileurl=$(curl -s https://api.github.com/repos/qishibo/AnotherRedisDesktopManager/releases/latest | jq -r --arg filename $filename '.assets[] | select(.name == $filename) | .browser_download_url')
  wget -q -O $bin $fileurl
	chmod +x $bin
fi

# execute
$bin -f -i $1 -o $2
