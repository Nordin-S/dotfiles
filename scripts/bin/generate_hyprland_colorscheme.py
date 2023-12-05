#!/usr/bin/env python
"""
Script: generate_hyprland_colorscheme.py
Author: Nordin Suleimani
Description: This script loads a pywal JSON file "colors.json" and generates a configuration file "colors-hyprland.conf" with variables for background, foreground, cursors, and color0 to color15.
"""

import json
import os

def hex_with_alpha(hex_color, alpha):
    """
    Add alpha value to a hex color code.

    Parameters:
        hex_color (str): Hex color code without alpha.
        alpha (str): Alpha value to be added.

    Returns:
        str: Hex color code with alpha.
    """
    hex_color = hex_color.lstrip("#")
    return hex_color + alpha

def generate_config(wal_path):
    """
    Generate the configuration file.

    Parameters:
        wal_path (str): Path to the wal cache directory.
    """
    alpha_value = "aa"

    # Read the JSON file
    with open(os.path.join(wal_path, 'colors.json'), 'r') as file:
        data = json.load(file)

    # Extract values
    background = data.get('special', {}).get('background', '').lstrip("#")
    foreground = data.get('special', {}).get('foreground', '').lstrip("#")
    cursor = data.get('special', {}).get('cursor', '').lstrip("#")
    colors = {f'color{i}': data.get('colors', {}).get(f'color{i}', '').lstrip("#") for i in range(16)}

    # Generate the configuration file content
    config_content = f"""\
# Auto-generated configuration file

$background = {hex_with_alpha(background, alpha_value)}
$foreground = {hex_with_alpha(foreground, alpha_value)}
$cursor = {hex_with_alpha(cursor, alpha_value)}
"""

    for key, value in colors.items():
        config_content += f"${key} = {hex_with_alpha(value, alpha_value)}\n"

    # Write the configuration file
    with open(os.path.join(wal_path, 'colors-hyprland.conf'), 'w') as config_file:
        config_file.write(config_content)

    print("Configuration file generated successfully.")

if __name__ == "__main__":
    wal_path = os.path.expanduser("~/.cache/wal/")
    generate_config(wal_path)
