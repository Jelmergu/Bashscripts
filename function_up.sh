#!/bin/bash

# This is a function for navigating directories. The function is able jump up more than one directory at a time
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function up {
    local amount=${1:-1}
    read -p "Continue:" choice
    choice=$(strictChoice "${choice}")
    echo ${choice}
    for (( i = 0; i < ${amount}; i++ )); do
        cd ../
    done
}