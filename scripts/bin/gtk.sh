#!/bin/sh

gnome_schema="gsettings set org.gnome.desktop.interface"
gnome_preferences="gsettings set org.gnome.desktop.wm.preferences"

THEME='Dracula'
ICON='candy-icons'
FONT='SauceCodePro Nerd Font Pro'
CURSOR='Bibata-Modern-Ice'

setTheme() {
  ${gnome_preferences} theme "$THEME"
  ${gnome_schema} cursor-theme "$CURSOR"
  ${gnome_schema} font-name "$FONT"
  ${gnome_schema} gtk-theme "$THEME"
  ${gnome_schema} icon-theme "$ICON"
}

setTheme
