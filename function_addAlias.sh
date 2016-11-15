#!/bin/bash
#

function addAlias { 
    local destination=""
    if [ -f ~/.bash_aliases ]
        then
        destination=~/.bash_aliases
    elif [ -f ~/.aliasses ]
        then
        destination=~/.aliasses
    else
        echo "Could not find alias location"
        return
    fi

    if [ -z "${1}" -a -z "${2}" ]
        then
        cat ${destination}
    elif [ -z "${1}" ]
        then
        echo "no name specified"

    elif [ -z "${2}" ]
        then
        echo "no command specified for ${1}"
    
    else
        echo "alias ${1}='${2}'" >>${destination}
        local directory="${PWD}"
        rebash
        cd ${directory}
    fi
}