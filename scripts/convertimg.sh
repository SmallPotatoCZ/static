#! /bin/bash

filename=""

for type in $( ls media ); do
    for size in $( ls media/$type ); do
        for file in $( ls media/$type/$size ); do
            if [[ -f media/$type/$size/$file ]]; then 
                convert media/$type/$size/$file -resize 256x171 media/$type/$size/small/${file%.*}.${file##*.}
            fi
        done 
    done
done