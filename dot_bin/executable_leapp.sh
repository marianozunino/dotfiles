#!/bin/bash

bin=~/.bin/leapp

# if leapp binary is not found, download it

if [ ! -f $bin ]; then
  notify-send -u normal "⏬ Leapp" "Downloading Leapp..."
	url="https://asset.noovolari.com/latest/Leapp-appImage.zip"
	wget -q -O /tmp/leapp.zip $url
  unzip -o /tmp/leapp.zip
  # release/Leapp-0.20.0.AppImage
  mv release/Leapp-0.20.0.AppImage $bin
	chmod +x $bin
fi

# execute leapp
$bin -f -i $1 -o $2
