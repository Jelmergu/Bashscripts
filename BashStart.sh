#!/bin/bash

bashLibraryDir=$(dirname "${BASH_SOURCE[0]}")

function includeDirectory {
    local dir=${1}

    for d in "${dir}"/*
    do

        if [ "${d}" == "." -o "${d}" == ".." -o "${d}" == "${BASH_SOURCE[0]}" ]
         then
            echo > /dev/null
        elif [ -d "${d}" ]
        then
            includeDirectory ${d}
        elif [ "${d: -3}" == ".sh" ]
        then
            . "${d}"
        fi
    done
}

includeDirectory $(dirname "${BASH_SOURCE[0]}")/startup &

includeDirectory $(dirname "${BASH_SOURCE[0]}")/functions
