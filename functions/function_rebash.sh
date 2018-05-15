#!/bin/bash

function rebash {
    local dir=${PWD}

    if [ -f /etc/bash.bashrc ]
        then
        . /etc/bash.bashrc
    elif [ -f ~/.bashrc ]
        then
        . ~/.bashrc
    else
        echo "Could not find bashrc location"
        return 0
    fi
    cd "${dir}"
}