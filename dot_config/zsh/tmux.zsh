if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	echo "Welcome stranger..."
#startx?
elif [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	startx
	exit
elif [ -z $TMUX ]; then
	tmux ls 2> /dev/null
	if [ $? -ne 0 ]; then
		echo "Press any to to cancel the tmux love..."
		read -t 0.7 -n 1 -s -r
		if [ $? -ne 0 ]; then
			tmux new -s default
		fi
	else
		# attach to the default session or create it if it doesn't exist
		tmux attach -t default || tmux new -s default
	fi
fi


function tmuxLauncher {
 	dir=$(/bin/fd --base-directory ~/Dev --search-path . -t d -d 2 | fzf)
 	git rev-parse --git-dir 2> /dev/null
 	if [[ $? -ne 0 ]] ;then
 		tmux rename-window $dir; cd "$HOME/Dev/$dir"
 	else
 		tmux new-window -n $dir -c "$HOME/Dev/$dir"
 	fi
 	zle reset-prompt
 }

 zle -N tmuxLauncher
 bindkey "^f" tmuxLauncher
 bindkey "^t" tmuxLauncher
