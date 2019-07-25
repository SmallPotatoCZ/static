#! /bin/bash

for size in $(find media/images/ -mindepth 1 -maxdepth 1 -type d); do
    if [[ ! -d $size/small ]]; then
        mkdir -p $size/small
    fi
    for file in $(find $size -mindepth 1 -maxdepth 1 -type f -name "*.jpg" -o -name "*.png"); do
        f=$(basename $file)
        if [[ ! -f $size/small/${f%.*}.${f##*.} ]]; then
            echo "convert $file"
            convert $file -resize 256 $size/small/${f%.*}.${f##*.}
        fi
    done
done
