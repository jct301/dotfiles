#!/usr/bin/env bash 

COLORSCHEME="doom-one"
picom &
/usr/bin/emacs --daemon &
killall conky &
sleep 3 && conky -c "$HOME"/.config/conky/qtile/"$COLORSCHEME"-01.conkyrc
nm-applet &
killall volumeicon &
volumeicon &
cbatticon &

xargs xwallpaper --stretch < ~/.cache/wall &
