#! /bin/bash

host=https://static.zhangchao.online

echo "# static" > list.md

for filename in $( ls ./media/images/3x2 ); do
    echo "1. $host/media/images/3x2/$filename" >> list.md
done