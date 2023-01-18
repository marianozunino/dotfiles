#!/bin/bash
toggle() {
    if xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Enabled.*:.*0" ; then
        echo "TouchPad:  "
        xinput enable "SynPS/2 Synaptics TouchPad" > /dev/null
    else
        xinput disable "SynPS/2 Synaptics TouchPad" > /dev/null
        echo "TouchPad:  "
    fi
}

show(){
    if xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Device Enabled.*:.*0"; then
        echo "TouchPad:  "
    else
        echo "TouchPad:  "
    fi
}

if [ $1 == "--show" ]; then
    show
fi
if [ $1 == "--toggle" ]; then
    toggle
fi
