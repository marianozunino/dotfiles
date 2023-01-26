#!/bin/bash

# Install packages
yay -S fzf asdf-vm --noconfirm

# add asdf plugins for node 
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs 16.10.0

# add asdf plugins for golang
asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf install golang 1.19.5

# add asdf plugins for bitwarden
asdf plugin add bitwarden https://github.com/vixus0/asdf-bitwarden
asdf install bitwarden v1.22.1


echo "nodejs 16.10.0
chezmoi 2.29.2
bitwarden v1.22.1
golang 1.19.5" > ~/.tool-versions


~/.asdf/shims/bw logout 2> /dev/null
PRESENT_GPG=$(gpg --list-secret-keys | grep marianoz@posteo.net)

if [ -z "$PRESENT_GPG" ]; then
  echo "GPG key not found, importing it"
  SESSION=$(~/.asdf/shims/bw login | grep -oP 'export BW_SESSION="\K[^"]+')
  GPG_KEY=$(bw get notes "GPG<marianoz@posteo.net>" --session $SESSION)

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
