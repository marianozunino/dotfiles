#!/bin/bash

bin=~/.bin/leapp

# if leapp binary is not found, download it

if [ ! -f $bin ]; then
	echo "Downloading leapp binary..."
	url="https://asset.noovolari.com/latest/Leapp-0.14.3.AppImage"
	wget -q -O $bin $url
	chmod +x $bin
fi

# execute leapp
$bin -f -i $1 -o $2
