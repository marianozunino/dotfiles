#!/bin/bash
URL=$(curl https://www.sublimemerge.com/download_thanks?target=x64-tar#direct-downloads | grep -oP 'https://download.sublimetext.com/sublime_merge_build_\d+_x64.tar.xz' | head -n 1)
VERSION=$(echo $URL | grep -oP '\d+' | head -n 1)
FILENAME=sublime_merge_build_"$VERSION"_x64.tar.xz
bin=~/.bin/sm

# set current working directory to ~/.bin

cd ~/.bin

# if FILENAME exists, then exit
if [ ! -f $FILENAME ]; then
  notify-send -u normal "⏬ Sublime Merge" "Updating to version $VERSION"
  # wget only if file does not exist
  wget -nc $URL
  tar -xvf $FILENAME
fi

if [ ! -f $bin ]; then
  ln -fs $PWD/sublime_merge/sublime_merge $bin
fi

# run sm
$bin
