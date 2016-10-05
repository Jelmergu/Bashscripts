#!/bin/bash

# This function is a extention on git branch. 
# It will change to a new branch once it is created
# It will switch to master branch if it is ordered to delete a branch

function gitBranch {
    first=${1:-none}
    if [ "${1}" = "-d" ]
        then
        git checkout master
        git branch "${1}" "${2}" 
    elif [ "${first}" = "none" ]
        then
        git branch
    else
        git branch "${1}"
        git checkout "${1}"
    fi
}