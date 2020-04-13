#!/bin/sh

# load the xres
xrdb ~/.Xresources

# disable mouse acceleration
xset m 0 0

# set the monitor dpi
#xrandr --dpi 91.79x91.79
xrandr --dpi 72

# color tint for tired eyes
redshift -l 50.2:8.7 -t 6500:2700 &

# set the wallpaper
hsetroot -solid '#5d6f40' -tile patterns/metal_dark.png 

# set fontpath
xset +fp $HOME/.local/share/fonts
xset fp rehash

# start compositor
#compton -cCr11 &

# notification daemon
dunst &

# get rid of the mouse
unclutter &

# auto mount external media
udiskie &

# get the colors of the day
colorday > ~/doc/studium/homepage/colors.css

session=${1:-herb}

case $session in
	i3				) exec i3;;
	ob				) exec openbox-session;;
	herb			) exec herbstluftwm;;
	bspwm			) exec bspwm;;
	*				) echo "unknown";;
esac
