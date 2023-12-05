#!/usr/bin/env python

from pathlib import Path
from subprocess import run, PIPE, DEVNULL


def generate_thumbnail(video_file, output_folder):
    video_name = Path(video_file).stem
    thumbnail_path = Path(output_folder) / f"{video_name}.png"

    # Check if the thumbnail already exists
    if not thumbnail_path.is_file():
        run(
            [
                "ffmpeg",
                "-y",
                "-i",
                video_file,
                "-ss",
                "00:00:10",
                "-vframes",
                "1",
                "-vf",
                "scale=200:-1",
                str(thumbnail_path),
            ],
            stdout=PIPE,
            stderr=DEVNULL,
        )
        print(f"Generated thumbnail: {thumbnail_path}")
    else:
        print(f"Thumbnail already exists for: {video_name}")


def main():
    input_folder = Path.home() / "wallpapers/animated"
    output_folder = input_folder / "thumbnails"

    # Create the output folder if it doesn't exist
    output_folder.mkdir(parents=True, exist_ok=True)

    # if number of mp4 in input_folder != number of png in output_folder
    if len(list(input_folder.glob("*.mp4"))) != len(list(output_folder.glob("*.png"))):
        # Iterate through each MP4 file in the input folder
        for video_file in input_folder.glob("*.mp4"):
            generate_thumbnail(video_file, output_folder)


if __name__ == "__main__":
    main()
