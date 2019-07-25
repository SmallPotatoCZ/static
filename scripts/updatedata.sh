#! /bin/bash

target=./data/list.js

echo "var esl_list = {" >$target

for type in $(find media/ -mindepth 1 -maxdepth 1 -type d); do
    echo "\"$(basename $type)\":{" >>$target
    for size in $(find $type -mindepth 1 -maxdepth 1 -type d); do
        echo "\"$(basename $size)\":[" >>$target
        for file in $(find $size -mindepth 1 -maxdepth 1 -type f -name "*.jpg" -o -name "*.png"); do
            echo "\"$(basename $file)\"," >>$target
        done
        echo "]," >>$target
    done
    echo "}," >>$target
done

echo "};" >>$target
