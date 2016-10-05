#!/bin/bash

# This function can delete a directory and all files in that directory
# If no directory is specified it will delete current working directory
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function rd {
    directory=${1:-default}
    if [ ${directory} = "-h" ] 
        then
        echo "This function can remove a directory.
    usage: rd [-h] [directory]
        When no arguments are given, current directory will be deleted"
    elif [ ${directory} = "default" ] || [ ${directory} = "." ]
        then
        read -p "Delete current directory?: " choice
        if [ "$choice" = "y" ]
            then
            directory="${PWD##*/}"
            cd ../
            rm -Rf "${directory}"
            echo "${directory} deleted"
        fi

    else
        read -p "Delete ${directory}?: " choice
        if [ "$choice" = "y" ]
            then
            rm -Rf "${directory}"
            echo "${directory} deleted"
        fi
        echo "${directory} deleted"
        cd ${directory}
    fi
    echo 
}