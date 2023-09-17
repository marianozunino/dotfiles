#!/bin/sh

filename=$(date +%F_%T.mkv)

if [ -z $(pgrep wf-recorder) ]; then
  notify-send "Recording Started ($active)"
	if [ "$1" == "-s" ]; then
      wf-recorder -f $HOME/Videos/wf-recorder/$filename -a  -g "$(slurp -c "#FFFFFF")"
			sleep 2
			while [ ! -z $(pgrep -x slurp) ]; do wait; done
			pkill -RTMIN+8 waybar
	else if [ "$1" == "-w" ]
		then wf-recorder -f $HOME/Videos/wf-recorder/$filename -a  -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp -c "#FFFFFF" )" >/dev/null 2>&1 &
			 sleep 2
			 while [ ! -z $(pgrep -x slurp) ]; do wait; done
			 pkill -RTMIN+8 waybar
	else
		wf-recorder -f $HOME/Videos/wf-recorder/$filename -a  >/dev/null 2>&1 &
		pkill -RTMIN+8 waybar
	fi
	fi
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
