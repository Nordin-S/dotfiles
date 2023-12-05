#!/usr/bin/env python

import os
import subprocess
import argparse
import random
import time

def kill_mpvpaper():
    subprocess.run(["pkill", "mpvpaper"])

def set_colorscheme(selected_thumb):

    try:
        genColorScheme = os.path.expanduser('~/bin/genColorscheme.sh')
        launch_script_path = os.path.expanduser('~/.config/waybar/launch.sh')

        subprocess.run(['sh', genColorScheme, f'{selected_thumb}.png'])
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
        subprocess.run(['python', os.path.expanduser('~/bin/generate_thumbnails.py')])
        print(f"Init generate thumbs script")
    except FileNotFoundError:
        print("Error: Script not found.")

def main():
    # Get path param
    parser = argparse.ArgumentParser(description="Set an MP4 file as a video wallpaper using mpvpaper.")
    parser.add_argument("folder_path", help="Path to the folder containing MP4 files.")
    parser.add_argument("randomize", help="y/n for randomized live wallpaper")
    args = parser.parse_args()

    folder_path = args.folder_path
    isRandom = args.randomize

    # Generate thumbnails if need be
    gen_thumbs()

    selected_thumb = ""
    if isRandom == 'y': 
        # count number of png files in thumbnails directory and pick a random thumbnail
        png_files = [f for f in os.listdir(os.path.join(folder_path, "thumbnails")) if f.endswith(".png")]
        # randomly select an index from png_files
        random_index = random.randint(0, len(png_files) - 1)
        selected_thumb = os.path.splitext(png_files[random_index])[0]
        print(f"random thumb name: {selected_thumb}")

    else:
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
        
        # Set the selected thumb as the wallpaper and it's colorscheme
        set_colorscheme(selected_thumb)
        set_wallpaper(selected_thumb, folder_path)

        time.sleep(1)
        subprocess.run(['python', os.path.expanduser('~/bin/generate_hyprland_colorscheme.py')])

if __name__ == "__main__":
    main()

