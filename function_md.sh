#!/bin/bash

# Function that makes it easier to create directories using the linux shell
# After creating the directory, made directory will be made active directory
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function md {

    if [ -z "${1}" ]
    then
        echo "No directory specified"
    else
        # Split the path
        local currentPath=.
        IFS='/' read -ra ADDR <<< "${1}"
            # Navigate or create every parent directory
            for i in "${ADDR[@]}"; do
                echo "${i}"
                if [ ! -d "${currentPath}/${i}" ]
                    then
                    mkdir "${currentPath}/${i}"
                fi
                currentPath="${currentPath}/${i}"
            done
        # Change directory to the created directory
        cd "${1}"
    fi
}