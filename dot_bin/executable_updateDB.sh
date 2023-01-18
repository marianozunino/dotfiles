#!/bin/bash

OUT_DIR=/opt/
URL='https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz'
DIR="$(dirname "$(readlink -f "$0")")"
TAR_FILE=$DIR/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz
echo $TAR_FILE

curl -z $TAR_FILE -o $TAR_FILE -L $URL
sudo tar -xvzf $TAR_FILE -C $OUT_DIR
