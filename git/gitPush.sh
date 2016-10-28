#!/bin/bash

# Alias for git push which uses origin and current branch as default remote and branch
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitPush {
    branch=$(git rev-parse --abbrev-ref HEAD)
    remote="origin"
    next=""
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
                git commit -F gitCommit.txt
            else
                return 0
            fi
        
        elif [[ ${next} = "-b" ]]
            then
            branch=${var}
            next=""
        
        elif [[ ${next} = "-r" ]]
            then
            remote=${var}
            next=""
        
        else
            next=${var}
        fi
        
    done
    echo "git push ${remote} ${branch}"
    git push "${remote}" "${branch}"
}