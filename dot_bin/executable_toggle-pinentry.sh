#!/bin/sh

# Define the paths to the pinentry programs
rofi_entry="/usr/bin/pinentry-rofi"
curses_entry="/usr/bin/pinentry-curses"

# Get the current pinentry program
current=$(grep -E '^pinentry-program' ~/.gnupg/gpg-agent.conf | awk '{print $2}')

# Check if the current entry is different from the desired one
if [ "$current" = "$rofi_entry" ]; then
    # Replace the existing pinentry program with pinentry-curses
    sed -i -e "s|^pinentry-program .*$|pinentry-program $curses_entry|" ~/.gnupg/gpg-agent.conf
    echo "Switched to pinentry-curses"
elif [ "$current" = "$curses_entry" ]; then
    # Replace the existing pinentry program with pinentry-rofi
    sed -i -e "s|^pinentry-program .*$|pinentry-program $rofi_entry|" ~/.gnupg/gpg-agent.conf
    echo "Switched to pinentry-rofi"
else
    # If there is no existing pinentry program, add the desired one
    echo "pinentry-program $rofi_entry" >> ~/.gnupg/gpg-agent.conf
    echo "Switched to pinentry-rofi"
fi

