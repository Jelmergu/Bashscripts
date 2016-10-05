#!/bin/bash

# This function can clone a git repo to the specified destination. Unspecified destination will put the repo in current directory
# Also creates gitCommit and .gitignore file
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitClone {
    repo=${1:-none}
    destination=${2:-"."}
    if [ ${repo} = "none" ]
        then
        echo "No repository specified"
    else
        git clone "${repo}" ${destination}
        echo "" > gitCommit.txt

        if  [ -f ${destination}/.gitignore ]
            then
            echo "gitignore exists in repository"
        else
            cat ${destination}/.git/gitIgnoreTemplate.txt > ${destination}/.gitignore
        fi
        rm ${destination}/.git/gitIgnoreTemplate.txt

        if [ ${destination} == "." ] 
            then
            ${fullPath}=${PWD}
        else
            ${fullPath}="${PWD}/${destination}"
        fi
        echo ${fullPath} >> ~/gitrepos.txt
    fi
}