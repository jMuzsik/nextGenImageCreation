#!/bin/bash

# Create the folder to store Next Gen images
mkdir ./Images/JP2Files
mkdir ./Images/WebPFiles
mkdir ./Images/Placeholders

# Go into Image directory for easier understanding
cd Images

# Loop through all images in the Image directory
for file in *; do
  # This means, do not run this code on a directory, only on a file (-f)
  if [[ -f $file ]]; then

    fileName=$(echo $file | cut -d'.' -f 1) # something.jpg -> something

    # Create placeholder and move to Placeholder folder
    # These options are temporary and definitely have room for improvement
    if [[ $file == *.png ]]; then
      # -strip gets rid unnecessary metadata
      # -quality 1 - 100, specifies image quality
      # -resize creates thumbnail like images 4096@ = 64x64 16384@ 128x128
      convert $file -strip -quality 1 -colors 255 -resize 4096@ ./Placeholders/$fileName.png
    else
      convert $file -strip -quality 20 -resize 16384@ ./Placeholders/$fileName.jpg
    fi

    # Conversion to Next Gen formats, using solely imageMagick defaults
    convert $file ./WebPFiles/$fileName.webp
    convert $file ./JP2Files/$fileName.jp2

  fi

done

# Go back down
cd ..
