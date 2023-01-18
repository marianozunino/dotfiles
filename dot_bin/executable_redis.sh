#!/bin/bash

bin=~/.bin/redis

# if redis binary is not found, download it
if [ ! -f $bin ]; then
	echo "Downloading redis binary..."
  filename=$(curl -s https://api.github.com/repos/qishibo/AnotherRedisDesktopManager/releases/latest | jq -r '.assets[].name' | grep "AppImage")
  fileurl=$(curl -s https://api.github.com/repos/qishibo/AnotherRedisDesktopManager/releases/latest | jq -r --arg filename "Another-Redis-Desktop-Manager.1.5.8.AppImage" '.assets[] | select(.name == $filename) | .browser_download_url')
  wget -q -O $bin $fileurl
	chmod +x $bin
fi

# execute leapp
$bin -f -i $1 -o $2
