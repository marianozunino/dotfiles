#!/bin/sh

# initialize the repo with the command:
#   borg init --encryption=none /mnt/C1/borg_backups/ja_borg
# then run this script
#

REPOSITORY="/mnt/borg/borg_backups/forbi_borg_$(hostname)"

/usr/bin/borg create \
  --list \
  --progress \
  --filter=AM \
  --verbose \
  --stats \
  -C lz4 \
  --exclude '**/node_modules/' \
  $REPOSITORY::`date +%Y-%m-%d-%H-%M-%S` \
  /home/forbi/GDrive \
  /home/forbi/Sync \
  /home/forbi/Dev \
  /home/forbi/Desktop \
  /home/forbi/Documents \
  /home/forbi/Pictures \
  /home/forbi/yubikey-luks/ \
  /home/forbi/wow-fishing-bot \
  /home/forbi/.gnupg \
  /home/forbi/.bin \
  /home/forbi/.ssh \
  /home/forbi/.config/evolution \
  /home/forbi/.local/share/evolution \
  /home/forbi/Development/mzunino/hosting/transfer

sleep 5

borg prune -v $REPOSITORY --keep-daily=7 --keep-weekly=4 --keep-monthly=3 --keep-within=1d

# --- USEFULL SHIT ---

# go in to repo folder, to list available backups:
#   borg list .
# to mount one of them:
#   borg mount .::2016-04-25 ~/temp
# to umount:
#   borg umount ~/temp
# to delete single backup in a repo:
#   borg delete .::2016-04-25
