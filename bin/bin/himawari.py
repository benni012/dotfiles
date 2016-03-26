#!/usr/bin/env python3

from io import BytesIO
from json import loads
from time import strptime, strftime
from subprocess import call
from os import makedirs
from os.path import expanduser, split
from urllib.request import urlopen

from PIL import Image

# Configuration
# =============

# Increases the quality and the size. Possible values: 4, 8, 16, 20
level = 4

# Path to the output file
output_file = expanduser("~/.himawari/himawari-latest.png")

# ==============================================================================

def main():
    width = 550
    height = 550

    print("Updating...")
    with urlopen("http://himawari8-dl.nict.go.jp/himawari8/img/D531106/latest.json") as latest_json:
        latest = strptime(loads(latest_json.read().decode("utf-8"))["date"], "%Y-%m-%d %H:%M:%S")

    print("Latest version: {} GMT\n".format(strftime("%Y/%m/%d/%H:%M:%S", latest)))

    url_format = "http://himawari8.nict.go.jp/img/D531106/{}d/{}/{}_{}_{}.png"

    png = Image.new('RGB', (width*level, height*level))

    print("Downloading tiles: 0/{} completed".format(level*level), end="\r")
    for x in range(level):
        for y in range(level):
            with urlopen(url_format.format(level, width, strftime("%Y/%m/%d/%H%M%S", latest), x, y)) as tile_w:
                tiledata = tile_w.read()

            tile = Image.open(BytesIO(tiledata))
            png.paste(tile, (width*x, height*y, width*(x+1), height*(y+1)))

            print("Downloading tiles: {}/{} completed".format(x*level + y + 1, level*level), end="\r")
    print("\nDownloaded\n")

    makedirs(split(output_file)[0], exist_ok=True)
    png.save(output_file, "PNG")
    call(["convert", output_file, "-scale", "x1000", "-bordercolor", "black", "-border", "460x40", output_file])
    
    call(["feh", "--bg-fill", "--no-fehbg", output_file])

    print("Done!\n")

if __name__ == "__main__":
    main()
