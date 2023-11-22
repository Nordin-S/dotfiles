#!/usr/bin/env python
import subprocess
import sys

def run_command(command):
    subprocess.run(command, shell=True, check=True)

def play_pause_toggle(player):
    run_command(f"playerctl --player={player} play-pause")

def next_track(player):
    run_command(f"playerctl --player={player} next")

def previous_track(player):
    run_command(f"playerctl --player={player} previous")

def volume_up():
    run_command("pamixer -i 5")

def volume_down():
    run_command("pamixer -d 5")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python multimedia_control.py <action> [player]")
        print("Available actions: play_pause, next, prev, volume_up, volume_down")
        print("Player is optional and only needed for play_pause, next, and prev actions.")
        sys.exit(1)

    action = sys.argv[1]

    if action in ["play_pause", "next", "prev"] and len(sys.argv) < 3:
        print(f"Error: {action} action requires a player argument.")
        sys.exit(1)

    value = sys.argv[2] if len(sys.argv) == 3 else None

    if action == "play_pause":
        play_pause_toggle(value)
    elif action == "next":
        next_track(value)
    elif action == "prev":
        previous_track(value)
    elif action == "volume_up":
        volume_up()
    elif action == "volume_down":
        volume_down()
    else:
        print("Invalid action. Available actions: play_pause, next, prev, volume_up, volume_down")
        sys.exit(1)

