#!/bin/bash

bin=$HOME/.bin/nosql

# if nosql binary is not found, download it
if [ ! -f $bin ]; then
	echo "Downloading NoSql binary..."
	url="https://s3.nosqlbooster.com/download/releasesv7/nosqlbooster4mongo-7.1.17.AppImage"
	wget -q -O $bin $url
	chmod +x $bin
fi

# execute leapp
$bin
