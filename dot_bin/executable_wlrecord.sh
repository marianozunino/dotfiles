#!/bin/bash

# Set variables
VIDEOS_DIR="$HOME/Videos/wf-recorder"
FILENAME="$(date +%F_%T).mkv"
FULL_PATH="$VIDEOS_DIR/$FILENAME"

# Function to send notifications
notify() {
  notify-send -a "Recorder" "$@"
}

# Function to update Waybar
update_waybar() {
  pkill -RTMIN+8 waybar
}

# Check if wf-recorder is already running
if pgrep -x wf-recorder >/dev/null; then
  killall -s SIGINT wf-recorder
  notify "🟢 Recording Complete"

  # Wait for wf-recorder to finish
  while pgrep -x wf-recorder >/dev/null; do sleep 0.1; done

  update_waybar

  # Prompt for new filename using rofi
  new_name=$(rofi -dmenu -p "Enter a filename (without extension)")

  if [ -n "$new_name" ]; then
    latest_recording=$(ls -t "$VIDEOS_DIR"/*.mkv | head -n1)
    mv "$latest_recording" "$VIDEOS_DIR/${new_name}.mkv"
  fi
else
  # Use slurp to select a geometry
  geometry=$(slurp -c "#FFFFFF")

  if [ -z "$geometry" ]; then
    notify -u critical "Select a Region"
    exit 1
  fi

  notify "🔴 Recording Started"

  # Ensure the output directory exists
  mkdir -p "$VIDEOS_DIR"

  # Start recording
  wf-recorder -f "$FULL_PATH" -a -g "$geometry"

  if [ $? -ne 0 ]; then
    notify -u critical "Recording Failed"
    exit 1
  fi

  # Wait for slurp to finish
  while pgrep -x slurp >/dev/null; do sleep 0.1; done

  update_waybar
fi
