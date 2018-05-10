#!/bin/bash

bashLibraryDir=$(dirname "${BASH_SOURCE[0]}")

function includeDirectory {
    local dir=${1}

    if [ -z "${1}" ]
    then
        dir="."
    fi

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

function selfUpdate {
    local branchStatus=$(cd "${bashLibraryDir}" && git fetch origin && git status -b --porcelain)

    if [[ "$branchStatus" == *"behind"* ]]
    then
        if [[ $BASHLIBRARY_AUTOUPDATE = true ]]
        then
            (cd dirname "${BASH_SOURCE[0]}" && git pull --ff-only)
        else
            echo -e "BashLibrary is outdated and not allowed to autoupdate\n Run (cd $(dirname ${BASH_SOURCE[0]}) && git pull --ff-only) to update"
            echo -e "\t Alternativly you could set BASHLIBRARY_AUTOUPDATE to true to perform automatic updates"
        fi
    fi
}

selfUpdate && includeDirectory "${bashLibraryDir}"
