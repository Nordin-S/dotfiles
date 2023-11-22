#!/usr/bin/env python

import os
import subprocess
import argparse
# import time

def kill_mpvpaper():
    subprocess.run(["pkill", "mpvpaper"])

def set_colorscheme(selected_thumb):

    try:
        launch_script_path = os.path.expanduser('~/.config/waybar/launch.sh')
        updatewall_script_path = os.path.expanduser('~/narch-scripts/updatewal-swww.sh')

        subprocess.run(['sh', updatewall_script_path, f'{selected_thumb}.png'])
        subprocess.run(['sh', launch_script_path])
        
    except Exception as e:
        print(f"Error: {e}")

def set_wallpaper(selected_thumb, folder_path):
    mp4_file = os.path.join(folder_path, f"{selected_thumb}.mp4")
    try:
        subprocess.run(["mpvpaper", "-o", "no-audio loop", "*", mp4_file])
        print(f"Video wallpaper set to: {mp4_file}")
    except FileNotFoundError:
        print("Error: mpvpaper tool not found. Make sure it is installed and in your PATH.")

def gen_thumbs():
    try:
        thumbs_command = ['python', "generate-thumbnails.py"]
        thumbs_gen_process = subprocess.Popen(thumbs_command, stdout=subprocess.PIPE, text=True)
        thumbs_result, _ = thumbs_gen_process.communicate()
        print(f"Init generate thumbs script")
    except FileNotFoundError:
        print("Error: Script not found.")

def main():
    # Get path param
    parser = argparse.ArgumentParser(description="Set an MP4 file as a video wallpaper using mpvpaper.")
    parser.add_argument("folder_path", help="Path to the folder containing MP4 files.")
    args = parser.parse_args()

    folder_path = args.folder_path

    # Generate thumbnails if need be
    gen_thumbs()

    # Display thumbnails with feh and get the selected thumb
    feh_command = [
        "feh", "-t", "--thumb-width=200", "--index-info", "",
        "--action", 'echo %n && pkill feh', 
        "--title", "%n",
    os.path.join(folder_path, "thumbnails")]
    feh_process = subprocess.Popen(feh_command, stdout=subprocess.PIPE, text=True)
    selected_thumb, _ = feh_process.communicate()

    # Remove newline character from the selected_thumb
    selected_thumb = os.path.splitext(selected_thumb.strip())[0]
    # selected_thumb = selected_thumb.strip()

    if selected_thumb:
        kill_mpvpaper()
        # time.sleep(1)
        # Set the selected thumb as the wallpaper and it's colorscheme
        set_colorscheme(selected_thumb)
        set_wallpaper(selected_thumb, folder_path)

if __name__ == "__main__":
    main()

