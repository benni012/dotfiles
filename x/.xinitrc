#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Load the xres
xrdb ~/.Xresources

# Disable mouse acceleration
xset m 0 0

# Set the monitor dpi
#xrandr --dpi 91.79x91.79
xrandr --dpi 92x92

# Start f.lux
#xflux -l 50.2 -g 8.7 &
redshift -l 50.2:8.7 -t 6500:2700 &

# Set the volume
#amixer -- set Master -19dB

# The wallpaper daemon
#/home/ben/scripts/wallpaperd &
#hsetroot -full ~/walls/winter.jpg &
#wallshuf &
#cwl
hsetroot -solid "#002b36" -tile ~/patterns/pattern.png

# Fontpath
xset +fp /home/ben/.local/share/fonts
xset fp rehash

# start compositor
compton -cCr11 --backend glx --vsync opengl-swc &

# notification daemon
dunst &

# get rid of the mouse
unclutter &

session=$1

case $session in
	i3				) exec i3;;
	ob				) exec openbox-session;;
	herb			) sxhkd & exec herbstluftwm;;
	bspwm			) exec bspwm;;
esac
