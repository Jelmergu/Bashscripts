#!/bin/bash

# This function is a extension on git branch.
# It will change to a new branch once it is created
# It will switch to master branch if it is ordered to delete a branch

function gitBranch {
    local first=${1:-"none"}
    # Check if the delete flag was set
    if [ "${1}" = "-d" ]
        then
        git checkout master
        git branch -D "${2}"

    # If no options are given, only display the local branches
    elif [ "${first}" = "none" ]
        then
        git branch
    # In other cases create a new branch
    else
        git branch "${1}"
        git checkout "${1}"
    fi
}