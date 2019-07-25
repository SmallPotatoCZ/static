#! /bin/bash
targetResolution="1920x1080"
cropRangle=""

CropResult() {
    set -f
    IFS='x' read -ra or <<<"$1"
    IFS='x' read -ra tr <<<"$2"
    oRatio=$(echo "scale=2;${or[0]}/${or[1]}" | bc)
    tRatio=$(echo "scale=2;${tr[0]}/${tr[1]}" | bc)
    echo "$oRatio---$tRatio"
    if [[ ${oRatio%%.*} -lt ${tRatio%%.*} || ${oRatio##*.} -lt ${tRatio##*.} ]]; then
        echo "lt"
        w=${or[0]}
        h=$(expr ${or[0]} / 16 * 9)
        diff=$(expr ${or[1]} - $h)
        y=$(expr $diff / 2)
        cropRangle="${w}x${h}+0+${y}"
    elif [[ ${oRatio%%.*} -eq ${tRatio%%.*} && ${oRatio##*.} -eq ${tRatio##*.} ]]; then
        echo "eq"
        cropRangle="${or[0]}x${or[1]}+0+0"
    else
        echo "gt"
        h=${or[1]}
        w=$(expr ${or[1]} / 9 * 16)
        diff=$(expr ${or[0]} - $w)
        x=$(expr $diff / 2)
        cropRangle="${w}x${h}+${x}+0"
    fi
}

for size in $(find local/ -mindepth 1 -maxdepth 1 -type d); do
    od="media/images/$(basename $size)"
    if [[ ! -d $od ]]; then
        mkdir -p $od
    fi
    for file in $(find $size -mindepth 1 -maxdepth 1 -type f -name "*.jpg" -o -name "*.png"); do
        imgRdtio=$(convert $file -print "%wx%h" /dev/null)
        CropResult $imgRdtio $targetResolution
        convert $file -crop $cropRangle -resize $targetResolution $od/$(uuidgen).${file##*.}
        rm -f $file
    done
done
