#!/bin/sh
# Convert all arguments (assumed to be SVG) to a TIFF.
# Requires Inkscape and ImageMagick 6.8 (doesn't work with 6.6.9).
# From matsen: https://gist.github.com/matsen/4263955

for i in $@; do
  BN=$(basename $i .svg)
  inkscape --export-png="$BN.png" --export-dpi 300 $i
  convert -compress LZW -alpha remove $BN.png $BN.tiff
  mogrify -alpha off $BN.tiff
  rm $BN.png
done
