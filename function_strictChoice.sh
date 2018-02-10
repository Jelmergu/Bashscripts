#!/bin/bash

function strictChoice() {
    local choice=${1}
    while [[ "${choice}" != "y" && "${choice}" != "n" ]]
    do
        read -p "${choice} is invalid, please use either 'y' or 'n': " choice
    done

    echo ${choice}
}