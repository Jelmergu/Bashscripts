#!/bin/bash

# Alias for git pull which uses origin and master as default remote and branch
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitPull {
    branch=$(git rev-parse --abbrev-ref HEAD)
    remote="origin"
    next=""
    for var in $@
    do
        if [[ ${next} = "-b" ]]
            then
            branch=${var}
            next=""
        elif [[ ${next} = "-r" ]]
            then
            remote=${var}
            next=""
        else
            next=${var}
        fi
    done
    git pull "${remote}" "${branch}"
}