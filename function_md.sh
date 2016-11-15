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
        mkdir "${1}"
        cd "${1}"
    fi
}