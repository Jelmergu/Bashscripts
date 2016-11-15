#!/bin/bash

# Alias for git push which uses origin and current branch as default remote and branch
# 
# @author Jelmer Wijnja


function gitPush {

# offlimit options: -v,--verbose, -q, --quiet, --repo, --all, --mirror, -d, --delete, --tags, --n, -n, --dry-run, --porcelain, -f, --force, --force-with-lease,
#   --recurse-submodules, --thin, --receive-pack, --exec, -u, --set-upstream, --progress, --prune, --no-verify, --follow-tags, --signed, --atomic, -o, --push-option,
#   -4, --ipv4, -6, --ipv6
# Already used by git push
    local option="${@}"
    local branch=""
    local remote=""
    local i=0

    local upstream=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
    IFS='/' read -ra ADDR <<< "$upstream"
    for i in "${ADDR[@]}"; do
        if [ -z ${remote} ]
        then
            remote="${i}"

        elif [ -z "${branch}" ]
        then
            branch="${i}"

        else
            branch="${branch}/${i}"
        fi
    done

    if [ -n "${branch}" ]
    then
        branch=$(git rev-parse --abbrev-ref HEAD)
    fi

    if [ -n "${remote}" ]
    then
        remote="origin"
    fi


    if [ -n $(contains "${option}" "-ct") ]
        then
        i=$(contains "${option}" "-ct")
        option=("${option[@]:$!i}")
            echo "On branch ${branch}"
            git status -s

            read -p "Continue: " choice
            while [ "${choice}" != "y" -a "${choice}" != "n" ]
            do
                read -p "${choice} is invalid, please use either 'y' or 'n': " choice
            done

            if [ ${choice} == "y" ]
                then
                git add .
                git commit -F  $(git rev-parse --git-dir)/../gitCommit.txt
            else
                return 0
            fi
    fi

    if [ -n $(contains "${option}" "-b") ]
        then
        i=$(contains "${option}" "-b")
        option=("${option[@]:$!i}")
        ((i++))
        branch="${!i}"
        option=("${option[@]:$!i}")
    fi
    if [ -n $(contains "${option}" "-r") ]
        then
        i=$(contains "${option}" "-r")
        option=("${option[@]:$!i}")
        ((i++))
        remote="${!i}"
        option=("${option[@]:$!i}")
    fi
    echo "${option[@]}"
#    git push "${option[@]}""${remote}" "${branch}"
}
