#!/bin/bash

bin=~/.bin/openlens

repo=MuhammedKalkan/OpenLens
# if redis binary is not found, download it
if [ ! -f $bin ]; then
	echo "Downloading openlens binary..."
  filename=$(curl -s https://api.github.com/repos/$repo/releases/latest | jq -r '.assets[].name' | grep "x86_64.AppImage$")
  fileurl=$(curl -s https://api.github.com/repos/$repo/releases/latest | jq -r --arg filename $filename '.assets[] | select(.name == $filename) | .browser_download_url')
  wget -q -O $bin $fileurl
	chmod +x $bin
fi

# execute leapp
$bin -f -i $1 -o $2
