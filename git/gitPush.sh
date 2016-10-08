#!/bin/bash

# Alias for git push which uses origin and current branch as default remote and branch
# 
# @author Jelmer Wijnja


function gitPush {

# offlimit options: -v,--verbose, -q, --quiet, --repo, --all, --mirror, -d, --delete, --tags, --n, -n, --dry-run, --porcelain, -f, --force, --force-with-lease,
#   --recurse-submodules, --thin, --receive-pack, --exec, -u, --set-upstream, --progress, --prune, --no-verify, --follow-tags, --signed, --atomic, -o, --push-option,
#   -4, --ipv4, -6, --ipv6
# Already used by git push

    branch=$(git rev-parse --abbrev-ref HEAD)
    remote="origin"
    next=""
    option=""
    for var in $@
    do
        if [[ ${var} = "-ct" ]]
            then
            git status
            read -p "Continue: " choice
            if [[ ${choice} != "n" && ${choice} != "no" && ${choice} != "No" && ${choice} != "N" ]]
                then
                git a
                git ct
            else
                return 0
            fi

        elif [[ ${var} = "-b" ]]
            then
            next=${var}

        elif [[ ${next} = "-b" ]]
            then
            branch=${var}
            next=""

        elif [[ ${var} = "-r" ]]
            then
            next=${var}

        elif [[ ${next} = "-r" ]]
            then
            remote=${var}
            next=""
        
        else
            if [[ ${next} != "" ]]
                then
                option="${option} ${next}"
                next=""
            fi
            next=${var}
        fi
    done
    option="${option} ${next}"
    echo "git push${option} ${remote} ${branch}"
    git push"${option} ${remote}" "${branch}"
}