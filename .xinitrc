#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# set dpi
xrandr --dpi 128

# merge in defaults and keymaps
if [ -f "$sysresources" ]; then
    xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]; then
    xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -f ~/.xprofile ]; then
    . ~/.xprofile
fi

# set color profile
xcalib -d :0 ~/.local/share/color/NE140FHM_N61.icm

# select wm/de with: startx ~/.xinitrc session
session=${1:-i3}

# set keyboard repeat rate
xset r rate 200 40

# set dpi
#xrandr --dpi 192

# screen locker
xset s off
#xset s 300 120
#xss-lock -n ~/.local/bin/dim-lights.sh -l -- ~/.local/bin/betterlockscreen -t 'Enter password to unlock.' -s &
#xss-lock -n ~/.local/bin/dim-lights.sh -l -- ~/.local/bin/betterlockscreen --off 30 -l dimblur -t 'Enter password to unlock.' &

# redshift
redshift -c .config/redshift/redshift.conf &

case "$session" in
    i3)
        exec i3 ;;
    kitty)
	exec kitty -o initial_window_width=1680 -o initial_window_height=1050 -o remember_window_size=no ;;
    *)
        exec "$session"
esac
