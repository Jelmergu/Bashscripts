function parseGitBranch {
    local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    
    if [[ "${branch}" == "" ]] # do not execute script if PWD is no git repo
        then
        return 0
    fi
    
    declare -A counter
    declare -A prefix
    declare -A stPrefix

    local counter=([modified]=0 [new]=0 [deleted]=0 [both]=0 [untracked]=0 [moved]=0 [ignored]=0 [noupdate]=0 [copied]=0)
    local prefix=([modified]=M [new]=N [deleted]=D [both]=BM [untracked]='?' [ignored]='!' [moved]=MV [noupdate]=NU [copied]=CP)
    local stPrefix=(
        [" M"]=noupdate
        [" D"]=noupdate

        ["M"]=modified
        ["M "]=modified
        ["MM"]=modified
        ["MD"]=modified

        ["A"]=new
        ["A "]=new
        ["AM"]=new
        ["AD"]=new

        ["D"]=deleted
        ["D "]=deleted
        ["DM"]=deleted
        ["DA"]=deleted
        ["DR"]=deleted
        ["DC"]=deleted

        ["R"]=moved
        ["R "]=moved
        ["RM"]=moved
        ["RD"]=moved

        ['C']=copied
        ["C "]=copied
        ["CM"]=copied
        ["CD"]=copied

        ["DD"]=deleted
        ["AU"]=both
        ["UD"]=deleted
        ["UA"]=both
        ["DU"]=modified
        ["AA"]=both
        ["UU"]=both #might give MC
        ["??"]=untracked
        ["?"]=untracked
        ["!!"]=ignored
        ["!"]=ignored

        ["N"]=untracked
    )

    # detect changed, new, deleted, mergin and untracked files
    while read -r -d '' state file; do
        if [ "${#state}" -le "3" ]
        then
            lPrefix="${state}"
            [ "${state}" = '??' ] && lPrefix="N"
            change="${stPrefix[$lPrefix]}"
            ((counter[${change}]++))
        fi

    done < <(git status -z)

    local count=0 # for the index of both arrays
    local result=""
    for C in "${!counter[@]}"; do #iterate through array
        if [ ${counter[${C}]} != 0 ] # when any of the changes are detected generate a result
            then
            result="${result}${prefix[${C}]}:${counter[${C}]} " # the previous result+one of {M,N,D,BM,U}+amount of changes
        fi
        echo "${C} --- ${counter[${C}]}"
    done

    echo "git branch->${branch}{${result}}"
}
