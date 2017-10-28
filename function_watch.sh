#!/bin/bash

function Jwatch {
    echo "Starting watch"
    local option=("${@}")
    local dir="."
    local previous=""


    echo "defined locals"
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


    echo "performed if's"
    local md5=$(find "${dir}" -type f -exec md5sum {} \; | sort -k 2 | md5sum)
    echo "calculated checksum"
    while [ 1==1 ]
        do
        md5=$(find "${dir}" -type f -exec md5sum {} \; | sort -k 2 | md5sum)

        if [ "${md5}" != "${previous}" ]
            then
              echo "Difference detected, executing command"
              ${command}
        fi

        previous="${md5}"
        sleep 1
    done
    echo "exiting"
}