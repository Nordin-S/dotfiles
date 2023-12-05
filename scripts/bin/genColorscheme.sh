#!/bin/bash
# by Nordin-S (2023)
# -----------------------------------------------------

# -----------------------------------------------------
# Select specific wallpaper and create colorscheme
# -----------------------------------------------------
if [ -a "$HOME/wallpapers/animated/thumbnails/$1" ]; then
  echo "found thumnbnail, setting colorscheme: $1"
  wal -q -i "$HOME/wallpapers/animated/thumbnails/$1"
else
  echo "did not find thumnbnail"
fi

# -----------------------------------------------------
# Load current pywal color scheme
# -----------------------------------------------------
source "$HOME/.cache/wal/colors.sh"

# -----------------------------------------------------
# Copy selected wallpaper into .cache folder
# -----------------------------------------------------
cp "$wallpaper" "$HOME/.cache/wal/current_wallpaper.jpg"

# -----------------------------------------------------
# Set the new colorscheme
# -----------------------------------------------------
~/.config/waybar/launch.sh
sleep 1

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------
notify-send -i "$wallpaper" "Colorscheme and live Wallpaper updated"
