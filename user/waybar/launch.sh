#!/bin/sh

pkill waybar

if [[ $USER = "ket" ]]
then
	waybar -c ~/.config/waybar/config & -s ~/.config/waybar/style.css
else
	waybar &
fi
