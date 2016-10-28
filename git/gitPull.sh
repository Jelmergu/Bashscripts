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
    stashed=""

    if [[ $(git status) == *"working tree clean"* ]]
        then
        stashed="false"
    else
        git stash
        stashed="true"
    fi

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
    option="${option} ${next}"
    if [[ ${option} == " " ]]
        then
        option=""
    fi
    git pull "${option}""${remote}" "${branch}"
    if [[ ${stashed} == "true" ]]
        then
        git stash apply
        git stash drop
    fi

}