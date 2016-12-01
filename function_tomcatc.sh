#!/bin/bash

function tomcatc {

    local option=("${@}")

    if [ $(contains "${option[@]}" "-cp") != false ]
    then
        i=$(contains "${option[@]}" "-cp")
        unset option[$i]

        if [ -n ${tomcatServerApi} ]
        then
            option+="-cp ${tomcatServerApi} "
        else
            echo '$tomcatServerApi is not set'
            return 0
        fi
    fi

    if [ $(contains "${option[@]}" "-d") != false ]
    then
        i=$(contains "${option[@]}" "-d")
        unset option[$i]
        ((i++))
        option+="-d ${option[$i]}"
        unset option[$i]
    fi

    catalina stop &> /dev/null &
    javac ${option[@]}
    echo "done"
    catalina run &> /dev/null &
}
