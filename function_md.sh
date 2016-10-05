#!/bin/bash

# Function that makes it easier to create directories using the linux shell
# After creating the directory, made directory will be made active directory
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function md {
    directory=${1:-default}
    if [ ${directory} = "-h" ]
        then
        echo "This function is an extention on mkdir. 
The created directory will become the active directory

    usage: md [-h] [directory name]
"
    elif [ ${directory} = "default" ]
    then
        echo "No directory specified"
    else
        mkdir ${directory}
        cd ${directory}
    fi
}