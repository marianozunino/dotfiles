#!/bin/sh

filename=$(date +%F_%T.mkv)

if [ -z $(pgrep wf-recorder) ]; then
  notify-send "Recording Started ($active)"
  wf-recorder -f $HOME/Videos/wf-recorder/$filename -a  -g "$(slurp -c "#FFFFFF")"
  if [ $? -eq 1 ]; then
    notify-send -a "Recorder" -u critical "Recording Failed"
  fi
  sleep 2
  while [ ! -z $(pgrep -x slurp) ]; do wait; done
  pkill -RTMIN+8 waybar
else
  killall -s SIGINT wf-recorder
  notify-send "Recording Complete"
  while [ ! -z $(pgrep -x wf-recorder) ]; do wait; done
  pkill -RTMIN+8 waybar
  # name="$(zenity --entry --text "enter a filename")"
  # use rofi instead of zenity
  name="$(rofi -dmenu -p "enter a filename")"
  mv $(ls -d $HOME/Videos/wf-recorder/* -t | head -n1) $HOME/Videos/wf-recorder/$name.mkv
fi
