#!/usr/bin/env python
"""
multimedia_ctl.py

Control multimedia players and system volume from the command line.

Author: Nordin Suleimani
Date: 2023-12-05
Version: 1.0

Usage:
    python multimedia_ctl.py <action> [player]

Actions:
    - play_toggle: Toggle play/pause for the specified player.
    - mute_toggle: Toggle mute for the system.
    - next: Play the next track for the specified player.
    - prev: Play the previous track for the specified player.
    - inc: Increase volume for the specified player or system.
    - dec: Decrease volume for the specified player or system.

Player:
    - Specify the player name as an optional argument. Use '-a' to affect all players.

Examples:
    - python multimedia_ctl.py play_toggle spotify
    - python multimedia_ctl.py play_toggle -a
    - python multimedia_ctl.py mute_toggle
    - python multimedia_ctl.py next
    - python multimedia_ctl.py inc

Dependencies:
    - playerctl
    - pamixer
    - dunst/dunstify

Note: Ensure that the required dependencies are installed before running the script.

"""
import subprocess
import os
import sys
import argparse
import logging

ICON_DIR = os.path.expanduser("~/icons/")
PLAYERCTL_CMD = "playerctl"
SYSTEMCTL_CMD = "pamixer"
VOLUME_STEP = 5
PLAYERCTL_VOLUME_STEP = VOLUME_STEP / 100

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def run_command(command):
    """Run a shell command and check for errors."""
    subprocess.run(command, shell=True, check=True)

def play_pause_toggle(option):
    """Toggle play/pause for the specified player."""
    run_command([f"{PLAYERCTL_CMD} {option} play-pause"])

def next_track(option):
    """Play the next track for the specified player."""
    run_command([f"{PLAYERCTL_CMD} {option} next"])

def prev_track(option):
    """Play the previous track for the specified player."""
    run_command([f"{PLAYERCTL_CMD} {option} previous"])

def play_mute_toggle():
    """Toggle mute for the system."""
    run_command(f"{SYSTEMCTL_CMD} -t")

def volume_up(option=None):
    """Increase volume for the specified player or system."""
    if option is not None:
        run_command([f"{PLAYERCTL_CMD} {option} volume {PLAYERCTL_VOLUME_STEP}+"])
    else:
        run_command(f"{SYSTEMCTL_CMD} -i {VOLUME_STEP}")

def volume_down(option=None):
    """Decrease volume for the specified player or system."""
    if option is not None:
        run_command([f"{PLAYERCTL_CMD} {option} volume {PLAYERCTL_VOLUME_STEP}-"])
    else:
        run_command(f"{SYSTEMCTL_CMD} -d {VOLUME_STEP}")

def ctrl_player(player, player_name):
    """Control multimedia players and system volume based on user action."""
    action = args.action

    if action == "play_toggle":
        play_pause_toggle(player)
        construct_notification(player, player_name)
    elif action == "mute_toggle":
        play_mute_toggle()
        construct_notification(player, player_name)
    elif action == "next":
        next_track(player)
    elif action == "prev":
        prev_track(player)
    elif action == "inc":
        volume_up(player)
        construct_notification(player, player_name)
    elif action == "dec":
        volume_down(player)
        construct_notification(player, player_name)
    else:
        logger.error("Invalid action. Available actions: play_toggle, mute_toggle, next, prev, inc, dec")
        sys.exit(1)

def get_icon(volume, is_muted="false"):
    """Get the icon path based on volume and mute status."""
    if volume < 1:
        volume = int(volume * 100)

    if is_muted == "true":
        return f"{ICON_DIR}volume-muted.svg"
    else:
        if volume == 0:
            return f"{ICON_DIR}volume-muted.svg"
        elif volume < 33:
            return f"{ICON_DIR}volume-low.svg"
        elif volume < 66:
            return f"{ICON_DIR}volume-medium.svg"
        else:
            return f"{ICON_DIR}volume-high.svg"

def construct_notification(player_flag, player_name):
    """Construct and display notifications."""
    current_volume = 0.0
    current_info = ""

    if player_flag is not None:
        current_volume = float(subprocess.check_output([PLAYERCTL_CMD, "volume"]).decode("utf-8").strip()) * 100
        status = subprocess.check_output([PLAYERCTL_CMD, "status"]).decode("utf-8").strip()

        if status == "Paused" or status == "Stopped":
            current_info = f"{player_name} not playing"
        else:
            current_info = f"{player_name} volume at {int(current_volume)}%"

    else:
        current_volume = float(subprocess.check_output([SYSTEMCTL_CMD, "--get-volume"]).decode("utf-8").strip())
        status = subprocess.check_output([SYSTEMCTL_CMD, "--get-mute"]).decode("utf-8").strip()

        if status == "true":
            current_info = "System is muted"
        else:
            current_info = f"System volume at {int(current_volume)}%"

    subprocess.run(["dunstify", "-i", get_icon(current_volume, status), "-u", "normal", current_info,
                    "-h", f"int:value:{int(current_volume)}", "-r", "6666"])

def parse_arguments():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(description="Control multimedia players and system volume.")
    parser.add_argument("action", choices=["play_toggle", "mute_toggle", "next", "prev", "inc", "dec"],
                        help="Action to perform")
    parser.add_argument("player", nargs="?", default=None, help="Optional player name")
    return parser.parse_args()

if __name__ == "__main__":
    args = parse_arguments()

    try:
        player_option = args.player
        player_name = "Player"
        if player_option and player_option != "-a":
            player_name = player_option.capitalize()
            player_option = f"--player={player_option}"

        ctrl_player(player_option, player_name)
    except KeyboardInterrupt:
        logger.info("\nScript terminated by user.")
    except Exception as e:
        subprocess.run(["dunstify", "-i", "error", "-u", "normal", f"Error: {e}", "-r", "6666"])
