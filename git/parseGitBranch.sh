#!/bin/bash


function parseGitBranch {
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) 
    
    if [[ "${branch}" == "" ]] # do not execute script if PWD is no git repo
        then
        return 0
    fi
    
    declare -A counter
    declare -A prefix
    declare -A stPrefix

    counter=([modified]=0 [new]=0 [deleted]=0 [both]=0 [untracked]=0)
    prefix=([modified]=M [new]=N [deleted]=D [both]=BM [untracked]=U)
    stPrefix=(["M"]=modified ["A"]=new ["D"]=deleted ["UU"]=both ["N"]=untracked)

    # detect changed, new, deleted, mergin and untracked files
    while read -r -d '' state file; do
        lPrefix="${state}"
        [ "${state}" = '??' ] && lPrefix="N"
        change="${stPrefix[$lPrefix]}"
        ((counter[${change}]++))
    done < <(git status -z)

    count=0 # for the index of both arrays
    result=""
    for C in "${!counter[@]}"; do #iterate through array
        if [ ${counter[${C}]} != 0 ] # when any of the changes are detected generate a result
            then
            result="${result}${prefix[${C}]}:${counter[${C}]} " # the previous result+one of {M,N,D,BM,U}+amount of changes
        fi
    done

    echo "git branch->${branch}{${result}}"
}