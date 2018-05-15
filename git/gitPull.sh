#!/bin/bash

# Alias for git pull which uses origin and master as default remote and branch
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitPull {
    local option=${@}
    local branch=$(git rev-parse --abbrev-ref HEAD)
    local remote="origin"
    local next=""
    local option=""
    local stashed="false"
    local status=$(git status -z)
    local i=""

    if [ $(contains "${option}" "-s") != false -o -n "${status}" ]
        then
        echo "git stash needed"
        git stash
        stashed="true"
    else
        echo "git stash not needed"
    fi

    if [ $(contains "${option}" "-b") != false ]
        then
        i=$(contains "${option}" "-b")
        option=("${option[@]:$!i}")
        ((i++))
        branch="${!i}"
        option=("${option[@]:$!i}")
    fi
    if [ $(contains "${option}" "-r") != false ]
        then
        i=$(contains "${option}" "-r")
        option=("${option[@]:$!i}")
        ((i++))
        remote="${!i}"
        option=("${option[@]:$!i}")
    fi
    git pull "${option}""${remote}" "${branch}"
    if [ ${stashed} == "true" ]
        then
        git stash apply
        git stash drop
    fi

}