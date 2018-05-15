#!/bin/bash

function selfUpdate {
    local branchStatus=$(cd "${bashLibraryDir}" && git fetch origin && git status -b --porcelain)

    if [[ "$branchStatus" == *"behind"* ]]
    then
        if [[ $BASHLIBRARY_AUTOUPDATE = true ]]
        then
            (cd dirname "${BASH_SOURCE[0]}" && git pull --ff-only)
        else
            echo -e "BashLibrary is outdated and not allowed to autoupdate\n\tRun (cd $(dirname ${BASH_SOURCE[0]}) && git pull --ff-only) to update"
            echo -e "\t Alternativly you could set BASHLIBRARY_AUTOUPDATE to true to perform automatic updates"
        fi
    fi
}

selfUpdate