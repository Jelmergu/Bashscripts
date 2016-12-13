#!/bin/bash

function watch {

    local option=("${@}")
    local dir="."
    local previous=""
    local md5=$(find "${dir}" -type f -exec md5sum {} \; | sort -k 2 | md5sum)



    if [ $(contains "${option[@]}" "-c") != false ]
    then
        i=$(contains "${option[@]}" "-c")
        ((i++))
        command="${option[$i]}"
    fi

        if [ $(contains "${option[@]}" "-d") != false ]
    then
        i=$(contains "${option[@]}" "-d")
        ((i++))
        dir="${option[$i]}"
    fi

    while [ 1==1 ]
        do
        md5=$(find "${dir}" -type f -exec md5sum {} \; | sort -k 2 | md5sum)
        echo "inWhile"
        if [ "${md5}" != "${previous}" ]
            then
              ${command}
        fi

        previous="${md5}"
        sleep 1
    done

}