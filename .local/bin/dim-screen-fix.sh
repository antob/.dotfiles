#!/bin/bash

# Example notifier script -- lowers screen brightness, then waits to be killed
# and restores previous brightness on exit.

## CONFIGURATION ##############################################################

# Brightness will be lowered to this value.
min_brightness=32

# Set this to use the sysfs interface and create a .conf file in /etc/tmpfiles.d/
# containing the following line to make the sysfs file writable for group
# "users":
#
#     m /sys/class/backlight/intel_backlight/brightness 0664 root users - -
#
sysfs_write_path=/sys/class/backlight/intel_backlight/brightness
sysfs_read_path=/sys/class/backlight/intel_backlight/actual_brightness

# Time to sleep (in seconds) between increments when using sysfs. If unset or
# empty, fading is disabled.
fade_step_time=0.00005

###############################################################################

get_brightness() {
    cat $sysfs_read_path
}

set_brightness() {
    echo $1 > $sysfs_write_path
}

fade_brightness() {
    if [[ -z $fade_step_time ]]; then
        set_brightness $1
    else
        local level
        for level in $(eval echo {$(get_brightness)..$1}); do
            set_brightness $level
            sleep $fade_step_time
        done
    fi
}

trap 'exit 0' TERM INT
trap "set_brightness $(get_brightness); kill %%" EXIT
fade_brightness $min_brightness
sleep 2147483647 &
wait
