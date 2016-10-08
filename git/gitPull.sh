#!/bin/bash

# Alias for git pull which uses origin and master as default remote and branch
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitPull {
    branch=$(git rev-parse --abbrev-ref HEAD)
    remote="origin"
    next=""
    option=""
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
            if [[ ${next} != "" ]]
                then
                option="${option} ${next}"
                next=""
            fi
            next=${var}
        fi
    done
    option="${option} ${next}"
    if [[ ${option} == " " ]]
        then
        option=""
    fi
    git pull "${option}""${remote}" "${branch}"
}