#!/bin/bash

OUT_DIR=/opt/
# URL='https://vscode-update.azurewebsites.net/1.51.0-insider/linux-x64/insider'
URL='https://code.visualstudio.com/sha/download?build=insider&os=linux-x64'
DIR="$(dirname "$(readlink -f "$0")")"
TAR_FILE=$DIR/latest.tar.gz
echo $TAR_FILE

curl -z $TAR_FILE -o $TAR_FILE -L $URL
sudo tar -xvzf $TAR_FILE -C $OUT_DIR
