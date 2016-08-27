#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# load the xres
xrdb ~/.Xresources

# disable mouse acceleration
xset m 0 0

# set the monitor dpi
#xrandr --dpi 91.79x91.79
xrandr --dpi 92x92

# start f.lux
redshift -l 50.2:8.7 -t 6500:2700 &

# the wallpaper daemon
hsetroot -solid '#5d6f40' -tile patterns/metal_dark.png 

# fontpath
xset +fp /home/ben/.local/share/fonts
xset fp rehash

# start compositor
#compton -cCr11 &

# notification daemon
dunst &

# get rid of the mouse
unclutter &

session=${1:-herb}

case $session in
	i3				) exec i3;;
	ob				) exec openbox-session;;
	herb			) exec herbstluftwm;;
	bspwm			) exec bspwm;;
	*				) echo "unknown";;
esac
