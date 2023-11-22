#!/bin/bash
# by Nordin-S (2023) 
# ----------------------------------------------------- 

# ----------------------------------------------------- 
# Select random/or specific wallpaper and create color scheme
# ----------------------------------------------------- 
if [ -a "$HOME/wallpapers/animated/thumbnails/$1" ]; then
    echo "found thumnbnail, setting colorscheme: $1"
    wal -q -i "$HOME/wallpapers/animated/thumbnails/$1"
else
    echo "did not find thumnbnail"
    wal -q -i "$HOME/wallpapers/"
fi


# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"

# $wallpaper = $(cat $HOME/.cache/wal/wal)
# ----------------------------------------------------- 
# Copy selected wallpaper into .cache folder
# ----------------------------------------------------- 
cp "$wallpaper" "$HOME/.cache/wal/current_wallpaper.jpg"

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$HOME/wallpapers/||g")

# ----------------------------------------------------- 
# Set the new wallpaper
# ----------------------------------------------------- 
swww img "$wallpaper" --transition-step=20 --transition-fps=20
~/.config/waybar/launch.sh
sleep 1

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 
notify-send "Colors and Wallpaper updated" "with image $newwall"

echo "DONE!"
