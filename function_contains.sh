#!/bin/bash


#source from: http://stackoverflow.com/questions/3685970/check-if-an-array-contains-a-value
function contains {

    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo ${i}
            return 1
        fi
    }
    echo false
    return 0
}