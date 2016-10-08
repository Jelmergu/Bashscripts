#!/bin/bash


function parseGitBranch {
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) 
    if [[ "${branch}" == "" ]] # do not execute script if PWD is no git repo
        then
        return 0
    fi
    declare -A counter
    declare -A prefix
    counter=([modified]=0 [new]=0 [deleted]=0 [both]=0 [untracked]=0)
    prefix=([modified]=M [new]=N [deleted]=D [both]=BM [untracked]=U)
    #detect changed, new, deleted and mergin files
    while IFS='' read -r line || [[ -n "$line" ]]; do
        for C in ${line}; do

            for K in "${!counter[@]}"; do # iterates through the keys
                if [[ ${C} == *${K}* ]]
                then
                    ((counter[${K}]++))
                fi
            done

        done
    done < <(git status)

    cDir=${PWD}
    cd $(git rev-parse --show-toplevel)
    # detect untracked files
    while IFS='' read -r line || [[ -n "$line" ]]; do
        for C in ${line}; do
            ((counter[untracked]++))
        done
    done < <(git ls-files --others --exclude-standard)
    cd ${cDir}

    count=0 # for the index of both arrays
    result=""
    for C in "${!counter[@]}"; do #iterate through array
        if [[ ${counter[${C}]} != 0 ]] # when any of the changes are detected generate a result
            then
            result="${result}${prefix[${C}]}:${counter[${C}]} " # the previous result+one of {M,N,D,BM,U}+amount of changes
        fi
    done

    echo "git branch->${branch}{${result}}"
}