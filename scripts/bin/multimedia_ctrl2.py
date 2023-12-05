#!/usr/bin/env python
import subprocess
import os
import time

lockfile = os.path.expanduser("~/volume-lockfile")
icon_dir = os.path.expanduser("~/.icons/oomox-xresources/")
playerctl_cmd = "playerctl"

while os.path.exists(lockfile):
    time.sleep(0.1)

open(lockfile, 'a').close()

def get_icon():
    status = subprocess.check_output([playerctl_cmd, "status"]).decode("utf-8").strip()
    volume = float(subprocess.check_output([playerctl_cmd, "volume"]).decode("utf-8").strip())

    if status == "Paused" or status == "Stopped":
        return f"audio-volume-muted-symbolic"
    else:
        if volume == 0:
            return f"audio-volume-muted-symbolic"
        elif volume < 0.33:
            return f"audio-volume-low-symbolic"
        elif volume < 0.66:
            return f"audio-volume-medium-symbolic"
        else:
            return f"audio-volume-high-symbolic"

change_by_value = 0.1
orig = float(subprocess.check_output([playerctl_cmd, "volume"]).decode("utf-8").strip())
newVolume = 0.0

if "mute" in os.sys.argv:
    subprocess.run([playerctl_cmd, "volume", "0"])
else:
    if "inc" in os.sys.argv:
        if len(os.sys.argv) > 2:
            change_by_value = float(os.sys.argv[2])
        newVolume = orig + change_by_value
    elif "dec" in os.sys.argv:
        if len(os.sys.argv) > 2:
            change_by_value = float(os.sys.argv[2])
        newVolume = orig - change_by_value

    subprocess.run([playerctl_cmd, "volume", f"{newVolume}"])

    # Fake the animated volume
    # for i in range(int(change_by_value*100.0)):
    #     operation = "+"
    #     inverse = "-"
    #     if "dec" in os.sys.argv:
    #         operation = "-"
    #         inverse = "+"
    #
    #     current = ((orig * 100.0) + eval(operation + str(i))) - 1
    #     if current < 0:
    #         current = 0
    #         os.remove(lockfile)
    #         exit(1)
    #     if current > 0:
    #         current = current/100
    #
    #     subprocess.run(["dunstify", "-i", get_icon(), "-u", "normal",
    #                     "-h", "string:x-dunst-stack-tag:volume",
    #                     f"Volume at {current}%",
    #                     "-h", f"int:value:{current}"])

current = float(subprocess.check_output([playerctl_cmd, "volume"]).decode("utf-8").strip())
status = subprocess.check_output([playerctl_cmd, "status"]).decode("utf-8").strip()
ntext = f"Volume at {int(current*100)}%"

if status == "Paused" or status == "Stopped":
    ntext = "Volume muted"

subprocess.run(["dunstify", "-i", get_icon(), "-u", "normal",
                ntext,
                "-h", f"int:value:{int(current*100)}", "-r", "6666"])

os.remove(lockfile)
