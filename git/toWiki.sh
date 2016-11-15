#!/bin/bash

function toWiki {

    #setting and checking root
    if [ -n $(contains "${option}" "-s") ]
        then
        root="${2}"

    elif [ -z "${root}" ]
        then
        echo "Root is not set, use 'toWiki -s [path-to-folder]' or set it during loading in for example .bashrc"
        return 0
    fi

    local next=""
    local wiki="${root}/wikis"

    # get the parent from the root
    IFS='/' read -ra dirs <<< "${root}"
    local n="${#dirs[@]}"
    local deepestParent="${dirs[${n}-1]}"

    local destination="${PWD}"
    #get the relative path
    while IFS='/' read -ra dirs
        do
            for i in "${dirs[@]}"
            do
                if [[ ${i} == "${deepestParent}" ]]
                    then
                    next='1'
                elif [[ ${i} == "wikis" ]]
                    then
                    retour='true'

                elif [[ ${next} == '1' ]]
                    then
                        destination="${destination}/${i}"
                fi
            done
        done <<< "${PWD}"

    # check which way we want to travel
    if [[ ${retour} == "true" ]]
        then
        destination="${root}/${destination}"
    else
        destination="${wiki}/${destination}"
    fi

    #check if the destination exists
    if [[ -d "${destination}" ]]
        then
        cd "${destination}"
    else
        echo "${destination} does not exist"
    fi

}