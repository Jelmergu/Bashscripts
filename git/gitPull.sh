#!/bin/bash

# Alias for git pull which uses origin and master as default remote and branch
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitPull {

    # Define some local variables
    local option=("${@}")
    local branch=$(git rev-parse --abbrev-ref HEAD)
    local remote=""
    local next=""
    local stashed="false"
    local status=$(git status -z)
    local i=""

    # Check if a stash should be executed
    if [ $(contains "${option[@]}" "-s") != false -o -n "${status}" ]
        then
        # Check if the stash is not forced
        if [ $(contains "${option[@]}" "-s") == false ]
        then
            # Ask to execute git stash
            read -p "Execute git stash? [y/n]: " choice
            while [ "${choice}" != "y" -a "${choice}" != "n" ]
            do
                read -p "${choice} is invalid, please use either 'y' or 'n': " choice
            done

            # Execute git stash
            if [ ${choice} == "y" ]
                then
                git stash
                stashed="true"
            fi
        # Execute forced git stash
        else
            git stash
            stashed="true"
        fi
        # Unset the -s flag
        i=$(contains "${option[@]}" "-s")
        unset option[$i]
    fi

    # Check if the branch has been specified
    if [[ $(contains "${option[@]}" "-b") != "false" ]]
        then
        # Remove branch flag and the branch, as they are not valid git pull options
        i=$(contains "${option[@]}" "-b")
        unset option[$i]
        ((i++))
        # Set the branch to be used
        branch="${option[$i]}"
        unset option[$i]
    fi

    # Check if the remote has been specified
    if [[ $(contains "${option[@]}" "-r") != "false" ]]
        then
        # Remove remote flag and the remote, as they are not valid git push options
        i=$(contains "${option[@]}" "-r")
        unset option[$i]
        ((i++))
        # Set the remote to be used
        remote="${option[$i]}"
        unset option[$i]
    fi

    # Determine the remote if it is not specified
    if [ -z ${remote} ]
        then
        # Get the upstream repository
        local upstream=$(git rev-parse --abbrev-ref "${branch}"@{upstream})
        IFS='/' read -ra ADDR <<< "$upstream"
        # The first in the array should be the remote
        local remote="${ADDR[0]}"
    fi

    # Check if verbose flag is set
     if [[ $(contains "${option[@]}" "-v") != "false" ]] || [[ $(contains "${option[@]}" "--verbose") != "false" ]]
        then
        # Output what to do
        read -p "git pull ${option[@]} ${remote} ${branch}"
    fi

    # Perform the actual git pull
    git pull "${option[@]}" "${remote}" "${branch}"

    # Check if a stash was executed
    if [ ${stashed} == "true" ]
        then
        # Unstash
        git stash apply
        git stash drop
    fi

}
