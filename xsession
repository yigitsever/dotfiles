#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

# disable screensaver, beep and power saving
xset -dpms &
xset s off &
xset -b &

# start the network manager (for no appearent reason?)
nm-applet &

# set the wallpaper and other visuals
hsetroot -center ~/Dropbox/Wallpapers/moon.jpg &
compton -b &
xsettingsd &

# start the screensaver
xidlehook --not-when-fullscreen --not-when-audio --timer normal 300 'betterlockscreen -l dimblur -t "Welcome Back"' &

# utilities
dropbox &
copyq &
conky --daemonize -c ~/.config/conky/conky.conf &
conky --daemonize -c ~/.config/conky/task.conf &

# keyboard with alt+shift us,tr switch, map escape to capslock
setxkbmap -model pc105 -layout us,tr -option grp:alt_shift_toggle,caps:swapescape &
