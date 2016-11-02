#!/bin/bash

# Alias for git push which uses origin and current branch as default remote and branch
# 
# @author Jelmer Wijnja


function gitPush {

# offlimit options: -v,--verbose, -q, --quiet, --repo, --all, --mirror, -d, --delete, --tags, --n, -n, --dry-run, --porcelain, -f, --force, --force-with-lease,
#   --recurse-submodules, --thin, --receive-pack, --exec, -u, --set-upstream, --progress, --prune, --no-verify, --follow-tags, --signed, --atomic, -o, --push-option,
#   -4, --ipv4, -6, --ipv6
# Already used by git push
    branch=""
    remote=""

    upstream=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
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

    next=""
    option=""
    for var in $@
    do
        if [[ ${var} = "-ct" ]]
            then
            echo "On branch ${branch}"
            git status -s
            read -p "Continue: " choice
            if [[ ${choice} != "n" && ${choice} != "no" && ${choice} != "No" && ${choice} != "N" ]]
                then
                git add .
                git commit -F  $(git rev-parse --git-dir)/../gitCommit.txt
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
    option="${option}${next}"
    if [[ ${option} == " " ]]
        then
        option=""
    fi

    git push "${option}""${remote}" "${branch}"
}
