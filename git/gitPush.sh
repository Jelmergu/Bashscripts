#!/bin/bash

# Alias for git push which uses origin and current branch as default remote and branch
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitPush {
# offlimit options: -v,--verbose, -q, --quiet, --repo, --all, --mirror, -d, --delete, --tags, --n, -n, --dry-run, --porcelain, -f, --force, --force-with-lease,
#   --recurse-submodules, --thin, --receive-pack, --exec, -u, --set-upstream, --progress, --prune, --no-verify, --follow-tags, --signed, --atomic, -o, --push-option,
#   -4, --ipv4, -6, --ipv6
# Already used by git push
    local option=("${@}")
    local branch=$(git rev-parse --abbrev-ref HEAD)
    local remote=""
    local i=0

    if [[ $(contains ${option[@]} "-ct") != "false" ]]
        then
        i=$(contains "${option[@]}" "-ct")
        unset option[$i]
        option=("${option[@]}")

        echo "On branch ${branch}"
        git status -s

        read -p "Continue: " choice
        while [ "${choice}" != "y" -a "${choice}" != "n" ]
        do
            read -p "${choice} is invalid, please use either 'y' or 'n': " choice
        done

        if [ ${choice} == "y" ]
            then
            git add --all
            git commit -F  $(git rev-parse --show-toplevel)/gitCommit.txt
        else
            return 0
        fi
    fi

    if [[ $(contains "${option[@]}" "-b") != "false" ]]
        then
        i=$(contains "${option[@]}" "-b")
        unset option[$i]
        ((i++))
        branch="${option[$i]}"
        unset option[$i]
    fi

    if [[ $(contains "${option[@]}" "-r") != "false" ]]
        then
        i=$(contains "${option[@]}" "-r")
        unset option[$i]
        ((i++))
        remote="${option[$i]}"
        unset option[$i]
    fi

    if [ -z ${remote} ]
        then
        local upstream=$(git rev-parse --abbrev-ref "${branch}"@{upstream})
        IFS='/' read -ra ADDR <<< "$upstream"
        remote="${ADDR[0]}"
    fi

    if [[ $(contains "${option[@]}" "-v") != "false" ]] || [[ $(contains "${option[@]}" "--verbose") != "false" ]]
        then
        read -p "git push ${option[@]} ${remote} ${branch}"
    fi

    git push "${option[@]}" "${remote}" "${branch}"
}
