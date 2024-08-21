function open {
    for i in $*
    do
        setsid nohup xdg-open $i > /dev/null 2> /dev/null
    done
}


function transfer {
    curl --progress-bar --upload-file "$1" https://transfer.mzunino.com.uy/$(basename "$1") | tee /dev/null;
    # curl --progress-bar --upload-file "$1" https://transfer.sh/$(basename "$1") | tee /dev/null;
    echo
}


function wacom {
  systemctl --user enable opentabletdriver --now
  otd loadsettings ~/Sync/wacom/wacom.json
}

function gc {
  if [[ "$1" == */* ]]
  then
    git clone "https://github.com/$1" "${@:2}"
  else
    git clone "https://github.com/marianozunino/$1" "${@:2}"
  fi
}


function croc-send {
  croc send --code mzunino "$@"
}

function croc-receive {
  croc --yes mzunino
}

if [[ -v TMUX ]]; then
  # inside tmux, we don't know if Sway got restarted
  function swaymsg {
    export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$UID.$(pgrep -x sway).sock
    command swaymsg "$@"
  }
fi


# expose local port to internet using my gh domain
function expose() {
  if [ -z "$1" ]; then
    echo "Usage: expose <port>"
    return
  fi
  ssh marianozunino@srv.us -R 1:localhost:$1
}

function _has {
  return $( whence $1 >/dev/null )
}

function sm {
  /opt/sublime_merge/sublime_merge $1
}


source ~/.local/share/zsh/rabbit-autocomplete.zsh
source ~/.local/share/zsh/run-on-pod-autocomplete.zsh


function vimrc {
  cd `ch source-path`
  nvim ~/.config/nvim/init.lua
  cd -
}
