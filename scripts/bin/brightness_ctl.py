#!/usr/bin/env python
"""
brightness_ctl.py

Adjust display brightness from the command line.

Author: Nordin Suleimani
Date: 2023-12-05
Version: 1.0

Usage:
    python brightness_ctl.py <direction> <percentage>

Directions:
    - inc: Increase brightness.
    - dec: Decrease brightness.

Percentage:
    - Change value in percentage [0-100%].

Examples:
    - python brightness_ctl.py inc 10
    - python brightness_ctl.py dec 20

Dependencies:
    - brightnessctl

Note: Ensure that the required dependency is installed before running the script.
"""

import subprocess
import argparse
import os

ICON_DIR = os.path.expanduser("~/icons/")

def get_icon(brightness):
    """Get the icon path based on brightness level."""
    if brightness == 0:
        return f"{ICON_DIR}brightness-low.svg"
    elif brightness < 10:
        return f"{ICON_DIR}brightness-low.svg"
    elif brightness < 33:
        return f"{ICON_DIR}brightness-medium.svg"
    elif brightness < 76:
        return f"{ICON_DIR}brightness-high.svg"
    else:
        return f"{ICON_DIR}brightness-max.svg"

def change_brightness(new_value):
    """Change the display brightness to the specified value."""
    subprocess.run(["brightnessctl", "s", f"{new_value}%"])

def main():
    """Main function to parse command line arguments and adjust brightness."""
    parser = argparse.ArgumentParser(description="Adjust display brightness")
    parser.add_argument("direction", choices=["inc", "dec"], help="Direction of brightness change")
    parser.add_argument("percentage", type=int, help="Change value in percentage [0-100%]")
    args = parser.parse_args()

    current = int(subprocess.check_output(["brightnessctl", "-P", "g"]).decode("utf-8").strip())

    if args.direction == "dec":
        current -= args.percentage
        current = max(5, current)
    elif args.direction == "inc":
        current += args.percentage
        current = min(100, current)
    else:
        exit(0)

    change_brightness(current)

    icon_path = get_icon(current)
    subprocess.run(["notify-send", f"Brightness at {current}%", "-i", icon_path,
                    "-h", f"int:value:{current}", "-r", "7777"])

if __name__ == "__main__":
    main()
