# Start typing + [Up-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "^k" up-line-or-beginning-search
bindkey -M viins "^k" up-line-or-beginning-search

# Start typing + [Down-Arrow] - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M vicmd "j" down-line-or-beginning-search
bindkey -M vicmd "^j" down-line-or-beginning-search
bindkey -M viins "^j" down-line-or-beginning-search

# Yank to the system clipboard
function vi-yank-wl() {
   zle vi-yank
   if [[ -z $CUTBUFFER ]]; then
     #
   else
    echo "$CUTBUFFER" | wl-copy
   fi
}
zle -N vi-yank-wl
bindkey -M vicmd "y" vi-yank-wl

