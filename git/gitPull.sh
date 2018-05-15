#!/bin/bash

# Alias for git pull which uses origin and master as default remote and branch
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitPull {
    local option=("${@}")
    local branch=$(git rev-parse --abbrev-ref HEAD)
    local remote=""
    local next=""
    local stashed="false"
    local status=$(git status -z)
    local i=""

    local upstream=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
    IFS='/' read -ra ADDR <<< "$upstream"
    for i in "${ADDR[@]}"; do
        if [ -z ${remote} ]
        then
            remote="${i}"

        elif [ -z "${branch}" ]
        then
            branch="${i}"

        else
            branch="${branch}/${i}"
        fi
    done

    if [ -n "${branch}" ]
    then
        branch=$(git rev-parse --abbrev-ref HEAD)
    fi

    if [ -n "${remote}" ]
    then
        remote="origin"
    fi

    if [ $(contains "${option[@]}" "-s") != false -o -n "${status}" ]
        then
        if [ $(contains "${option[@]}" "-s") == false ]
        then
            read -p "Execute git stash? [y/n]: " choice
            while [ "${choice}" != "y" -a "${choice}" != "n" ]
            do
                read -p "${choice} is invalid, please use either 'y' or 'n': " choice
            done

            if [ ${choice} == "y" ]
                then
                git stash
                stashed="true"
            fi

        else
            git stash
            stashed="true"
        fi
    fi

    if [[ $(contains "${option[@]}" "-b") != "false" ]]
        then
        i=$(contains "${option[@]}" "-b")
        unset option[$i]
        ((i++))
        branch="${option[$i]}"
        unset option[$i]
    fi

    if [[ $(contains "${option[@]}" "-r") != "false" ]]
        then
        echo "remote"
        i=$(contains "${option[@]}" "-r")
        unset option[$i]
        ((i++))
        remote="${option[$i]}"
        unset option[$i]
    fi

    if [[ $(contains "${option[@]}" "-v") != "false" ]] || [[ $(contains "${option[@]}" "--verbose") != "false" ]]
        then
        read -p "git pull ${option[@]} ${remote} ${branch}"
    fi

    git pull "${option}" "${remote}" "${branch}"

    if [ ${stashed} == "true" ]
        then
        git stash apply
        git stash drop
    fi

}