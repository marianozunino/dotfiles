#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
    monitors=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)
    if [ $monitors -eq 1 ]; then
        polybar --reload rigth &
    else
        polybar --reload left &
        polybar --reload rigth &
    fi
else
    polybar --reload rigth &
fi

echo "Bar launched..."
