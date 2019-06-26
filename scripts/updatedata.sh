#! /bin/bash

target=./data/list.js

echo "var esl_list = {" > $target

for type in $( ls media ); do
    echo "\"$type\":{" >> $target
    for size in $( ls media/$type ); do
        echo "\"$size\":[" >> $target
        for file in $( ls media/$type/$size ); do
            if [[ -f media/$type/$size/$file ]]; then 
                echo "\"$file\"," >> $target
            fi
        done 
        echo "]" >> $target
    done
    echo "}," >> $target
done

echo "};" >> $target