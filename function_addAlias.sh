#!/bin/bash
#

function addAlias { 
    naam=${1:-none}
    cmd=${2:-none}

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

    if [[ ${naam} = "none" && ${cmd} = "none" ]]
        then
        cat ${destination}

    elif [[ ${naam} = "none" ]]
        then
        echo "no name specified"

    elif [[ ${cmd} = "none" ]]
        then
        echo "no command specified for ${naam}"
    
    else
        echo "alias ${naam}='${cmd}'" >>${destination}
        directory="${PWD}"
        rebash
        cd ${directory}
    fi
}