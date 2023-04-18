#!/bin/bash

# add the following line to /etc/zsh/zshenv using sudo
# export ZDOTDIR=$HOME/.config/zsh
sudo sh -c "echo 'export ZDOTDIR=$HOME/.config/zsh' >> /etc/zsh/zshenv"

# Install packages
yay -S fzf git --noconfirm

export ASDF_DATA_DIR=$HOME/.local/share/asdf
export ASDF_CONFIG_FILE=$HOME/.config/asdf/asdfrc
export ASDF_DIR=$HOME/.local/share/asdf

git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.11.1

ASDF_BIN=$HOME/.local/share/asdf/bin/asdf
BITWARDEN_VERSION=v1.22.1

$ASDF_BIN plugin add bitwarden
$ASDF_BIN plugin add nodejs
$ASDF_BIN plugin add golang
$ASDF_BIN plugin add chezmoi

$ASDF_BIN install bitwarden $BITWARDEN_VERSION
$ASDF_BIN global bitwarden $BITWARDEN_VERSION

BW_BIN=$HOME/.local/share/asdf/shims/bw
$BW_BIN logout 2> /dev/null

PRESENT_GPG=$(gpg --list-secret-keys | grep marianoz@posteo.net)

if [ -z "$PRESENT_GPG" ]; then
  echo "GPG key not found, importing it"
  SESSION=`$BW_BIN login | grep -oP 'export BW_SESSION="\K[^"]+'`
  GPG_KEY=`$BW_BIN get notes "GPG<marianoz@posteo.net>" --session $SESSION`

  if echo "$GPG_KEY" | awk '{if($0 ~ /^-----BEGIN PGP PRIVATE KEY BLOCK-----/) {print "valid"} else {print "invalid"}}' | grep -q "valid"; then
    echo "The GPG key was read successfully"
  else
    echo "Error: Invalid GPG key format, it should starts with -----BEGIN PGP PRIVATE KEY BLOCK-----"
    exit 1
  fi

  read -sp "GPG Secret>" PASSWORD
  echo "$GPG_KEY" | gpg --import --batch --yes
  PASSWORD=""
  echo -e "trust\n5\ny\n" | gpg --command-fd 0 --edit-key marianoz@posteo.net
  exit 0
else
  echo "GPG key already present"
  exit 0
fi
