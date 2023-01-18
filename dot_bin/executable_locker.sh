# Run xidlehook
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Notify is getting locked in 10 sec` \
  --timer normal 300 \
    'pgrep -x i3lock || notify-send -t 9000 --urgency="normal" --app-name="xautolock" \
 			--icon="/usr/share/icons/Papirus-Dark/48x48/status/status_lock.svg" \
      		-- "Screen Lock" "In 10 sec..."' \
    '' \
  `# Undim & lock after 10 more seconds` \
  --timer primary 10 \
    'pgrep -x i3lock || betterlockscreen -l dim' \
    '' \
  --timer normal 60 \
   'xbacklight -set 10' \
   'xbacklight -set 80' \
  `# Finally, suspend 13 min after it locks` \
  --timer normal 600 \
    'sudo ZZZ' \
    ''
