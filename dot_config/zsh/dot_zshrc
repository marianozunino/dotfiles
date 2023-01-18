. $HOME/.asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

#####################################
#               BASE16              #
#####################################
BASE16_SHELL="$HOME/dotfiles/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"


#####################################
#               ZGEN                #
#####################################
if [[ ! -d ~/.config/zgen ]];then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.config/zgen"
fi
source "${HOME}/.config/zgen/zgen.zsh"

_has() {
    return $( whence $1 >/dev/null )
}

zgen oh-my-zsh
zgen oh-my-zsh plugins/gitfast
zgen oh-my-zsh plugins/common-aliases
zgen oh-my-zsh lib/completion.zsh
zgen oh-my-zsh lib/history.zsh
zgen oh-my-zsh lib/key-bindings.zsh
zgen load zsh-users/zsh-syntax-highlighting
zgen load sobolevn/wakatime-zsh-plugin

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
zgen load zsh-users/zsh-autosuggestions


MNML_INFOLN=()
MNML_PROMPT=(mnml_ssh  mnml_pyenv mnml_status 'mnml_cwd 2 0' mnml_git mnml_keymap )
MNML_RPROMPT=()

zgen load subnixr/minimal

#fzf plugin
if _has fzf; then
    zgen load junegunn/fzf shell/completion.zsh
    zgen load junegunn/fzf shell/key-bindings.zsh
fi

#
#
#
#####################################
#               ALIAS               #
#####################################
#load local alias
source $ZDOTDIR/.zsh_alias
if [ -f ~/dotfiles/zsh_local_alias ]; then
    source ~/dotfiles/zsh_local_alias
fi


#####################################
#               FZF                 #
#####################################
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f'
if _has fzf && _has rg; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --vimgrep --glob "!.git/*"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi

#####################################
#          ZSH CONFIG               #
#####################################
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=500000
SAVEHIST=500000
HISTORY_IGNORE='(*.git/hooks*)'
setopt interactivecomments
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# enable control-s and control-q
stty start undef
stty stop undef
setopt noflowcontrol

#complete with ...
expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
}
# zle -N expand-or-complete-with-dots
# bindkey "^I" expand-or-complete-with-dots

tmuxLauncher(){
    x=$(/bin/fd --base-directory ~/Development --search-path .  -t d -d 2 | fzf)
    git rev-parse --git-dir 2> /dev/null
    if [[ $? -ne 0 ]] ;then
        tmux rename-window $x; cd "/home/forbi/Development/$x"
    else
        tmux new-window -n $x -c "/home/forbi/Development/$x"
    fi
    zle reset-prompt
}

zle -N tmuxLauncher
bindkey "^f" tmuxLauncher
bindkey "^t" tmuxLauncher

tmuxSwitcher(){
    tmux-switcher
    zle reset-prompt
}
zle -N tmuxSwitcher
bindkey "^g" tmuxSwitcher

sdmPortFinder(){
		sdm status | grep -v "not connected" | grep connected | tr -s ' ' | cut -d ' ' -f 2,4 | fzf | cut -d ' ' -f 2 | xargs -I {} echo {} | xclip -selection clipboard
		zle reset-prompt
}
zle -N sdmPortFinder
bindkey "^p" sdmPortFinder

sdmConnect(){
		sdm status | grep "not connected" | tr -s ' ' | cut -d ' ' -f 2 | fzf | xargs -I {} sdm connect {}
		zle reset-prompt
}
zle -N sdmConnect
bindkey "^n" sdmConnect



#ssh?
# if VIMRUNTIME is set, then we're in vim, so don't do anything
if [ "$VIMRUNTIME" ]; then
    # elif [ $TERM_PROGRAM = "vscode" ]; then
    #     echo "VSCODE"
elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "Welcome stranger..."
    #startx?
elif [ -z "$DISPLAY" ] && [ "$(fgconsole)" = "1" ]; then
    startx
    exit
    #join the tmux club
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


source /usr/share/git-flow/git-flow-completion.zsh

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
