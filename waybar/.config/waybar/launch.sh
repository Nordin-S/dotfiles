#!/bin/sh
# by Nordin-S (2023) 
# ----------------------------------------------------- 

# Kill running waybar
# ----------------------------------------------------- 
killall waybar

# Loading specific conf
# ----------------------------------------------------- 
if [[ $USER = "narch" ]]
then
    waybar -c ~/.config/waybar/myconfig -s ~/.config/waybar/style.css & 
else
    waybar &
fi

