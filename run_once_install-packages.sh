#!/bin/bash

sudo sh -c 'echo "export ZDOTDIR=\$HOME/.config/zsh
[ -f \"\$HOME/.config/env\" ]  && source \$HOME/.config/env
" >> /etc/zsh/zshenv'
echo -e "trust\n5\ny\n" | gpg --command-fd 0 --edit-key marianoz@posteo.net
gpg-connect-agent "scd serialno" "learn --force" /bye
