#!/bin/bash

# Example notifier script -- lowers screen and keyboard brightness, then waits
# to be killed and restores previous brightness on exit.

## CONFIGURATION ##############################################################

# Screen brightness will be lowered to this value.
min_brightness=200

###############################################################################

get_screen_brightness() {
    brightnessctl get
}

set_screen_brightness() {
    brightnessctl -q set $1
}

get_kbd_brightness() {
    brightnessctl --device='tpacpi::kbd_backlight' get
}

set_kbd_brightness() {
    brightnessctl --device='tpacpi::kbd_backlight' -q set $1
}

trap 'exit 0' TERM INT
trap "set_screen_brightness $(get_screen_brightness); set_kbd_brightness $(get_kbd_brightness); kill %%" EXIT
set_screen_brightness $min_brightness
set_kbd_brightness 0
sleep 2147483647 &
wait
