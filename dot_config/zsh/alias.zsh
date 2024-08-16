alias fly='flyctl'
alias src='exec zsh'
alias dc="cd"
alias k="kubectl"
alias ks="kubens"
alias kx="kubectx"
alias lf="yazi"
alias slides=presenterm

alias cat="bat"
alias df="duf"

alias yay="paru --bottomup"
alias yeet="sudo pacman -Rns"

alias orphan="doas pacman -Rns (pacman -Qtdq)"
alias syncRepo="git fetch --all; git reset --hard origin/master"
alias sistra="cd ~/dev/sistra ; npm run dev"

alias yarn="corepack yarn"
alias yarnpkg="corepack yarnpkg"
alias pnpm="corepack pnpm"
alias pn="corepack pnpm"
alias pnpx="corepack pnpx"
alias npm="corepack npm"
alias npx="corepack npx"

alias chmox="chmod +x"

#fuck mkdir
alias mkdir="mkdir -pv"
# Donwload youtube audio
alias yta="youtube-dl --add-metadata -xic"
#
alias tmux='TERM=xterm-256color tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias ts="tmux ls"
alias ta="tmux attach -t default || tmux new -s default"

#cd folder
alias gD="cd ~/Desktop"
alias gd="cd ~/Downloads"
alias gr="cd ~/Development/"
alias gs="cd ~/Sync"
alias gdot="cd ~/.local/share/chezmoi/"
alias gkey="cd ~/.local/share/keyrings/"
alias gt="cd ~/Dev/"

#edit files
alias vim='nvim'

alias tmuxrc="vim $XDG_CONFIG_HOME/tmux/tmux.conf"
alias doomconf="vim ~/.config/gzdoom/gzdoom.ini"
alias vimrc="cd ~/.config/nvim/ && vim init.lua"
alias pluginconf="vim ~/.config/nvim/plugins.vim"
alias i3conf="vim ~/.config/i3/config"
alias cssh="vim ~/.ssh/config"

alias g='git'
alias next='feh --no-fehbg -z --bg-scale ~/Pictures/*'

alias gpi='cd ~/Development/pi'
alias gtt='cd ~/Development/tecnologo'
alias nubceo='cd ~/Development/nubceo'
alias vairix='cd ~/Development/vairix'
alias seekr='cd ~/Development/seekr'

# show sym links
alias lll='ls -l `find . -maxdepth 1 -type l -print`'
alias v='vim'
alias fd='/bin/fd'
#
# launch diary from command line:
alias vd='vim -c ":VimwikiMakeDiaryNote"'
## launch index page from command line
alias vw='vim -c ":VimwikiIndex"'
alias tf='terraform'
alias copy="xclip -sel clip"
alias paste="xclip -sel clip -o"

# Work related
alias sstack='cd ~/Dev/stuzo/oc-docker-compose; docker-compose up postgres redis rabbitmq'
alias gho="gh browse"

# chezmoi shorthand aliases
alias ch='chezmoi'

alias gh-clone='gc'
alias task='go-task'
