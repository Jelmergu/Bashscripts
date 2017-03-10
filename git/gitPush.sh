#!/bin/bash

# Alias for git push which uses origin and current branch as default remote and branch
# 
# @author Jelmer Wijnja


function gitPush {

# offlimit options: -v,--verbose, -q, --quiet, --repo, --all, --mirror, -d, --delete, --tags, --n, -n, --dry-run, --porcelain, -f, --force, --force-with-lease,
#   --recurse-submodules, --thin, --receive-pack, --exec, -u, --set-upstream, --progress, --prune, --no-verify, --follow-tags, --signed, --atomic, -o, --push-option,
#   -4, --ipv4, -6, --ipv6
# Already used by git push
    local option=("${@}")
    local branch=$(git rev-parse --abbrev-ref HEAD)
    local remote=""
    local i=0

    # check if the commit flag is set
    if [[ $(contains ${option[@]} "-cat") != "false" ]]
        then
        # Remove -ct flag from the options, is not a valid git push flag
        i=$(contains "${option[@]}" "-cat")
        unset option[$i]
        option=("${option[@]}")

        # Ask user if they want to commit everything
        echo "On branch ${branch}"
        git status -s

        read -p "Continue: " choice
        # Invalid choices
        while [ "${choice}" != "y" -a "${choice}" != "n" ]
        do
            read -p "${choice} is invalid, please use either 'y' or 'n': " choice
        done

        # Commit with a message taken from gitCommit
        if [ ${choice} == "y" ]
            then
            git add --all
            git commit -s -F  $(git rev-parse --show-toplevel)/gitCommit.txt
        # Do not commit
        else
            return 0
        fi
    fi

    if [[ $(contains ${option[@]} "-ct") != "false" ]]
        then
        # Remove -ct flag from the options, is not a valid git push flag
        i=$(contains "${option[@]}" "-ct")
        unset option[$i]
        option=("${option[@]}")

        # Ask user if they want to commit everything
        echo "On branch ${branch}"
        git status -s

        read -p "Continue: " choice
        # Invalid choices
        while [ "${choice}" != "y" -a "${choice}" != "n" ]
        do
            read -p "${choice} is invalid, please use either 'y' or 'n': " choice
        done

        # Commit with a message taken from gitCommit
        if [ ${choice} == "y" ]
            then
            git commit -s -F  $(git rev-parse --show-toplevel)/gitCommit.txt
        # Do not commit
        else
            return 0
        fi
    fi

    if [[ $(contains ${option[@]} "-cm") != "false" ]]
        then
        # Remove -ct flag from the options, is not a valid git push flag
        i=$(contains "${option[@]}" "-cm")
        unset option[$i]
        option=("${option[@]}")

        # Ask user if they want to commit everything
        echo "On branch ${branch}"
        git status -s

        read -p "Continue: " choice
        # Invalid choices
        while [ "${choice}" != "y" -a "${choice}" != "n" ]
        do
            read -p "${choice} is invalid, please use either 'y' or 'n': " choice
        done

        # Commit with a message taken from gitCommit
        if [ ${choice} == "y" ]
            then
            git commit -s
        # Do not commit
        else
            return 0
        fi
    fi

    if [[ $(contains ${option[@]} "-cam") != "false" ]]
        then
        # Remove -ct flag from the options, is not a valid git push flag
        i=$(contains "${option[@]}" "-cam")
        unset option[$i]
        option=("${option[@]}")

        # Ask user if they want to commit everything
        echo "On branch ${branch}"
        git status -s

        read -p "Continue: " choice
        # Invalid choices
        while [ "${choice}" != "y" -a "${choice}" != "n" ]
        do
            read -p "${choice} is invalid, please use either 'y' or 'n': " choice
        done

        # Commit with a message taken from gitCommit
        if [ ${choice} == "y" ]
            then
            git add --all
            git commit -s
        # Do not commit
        else
            return 0
        fi
    fi

    # Check if the branch has been specified
    if [[ $(contains "${option[@]}" "-b") != "false" ]]
        then
        # Remove branch flag and the branch, as they are not valid git push options
        i=$(contains "${option[@]}" "-b")
        unset option[$i]
        ((i++))
        # Set the branch to be used
        branch="${option[$i]}"
        unset option[$i]
    fi

    # Check if the remote has been specified
    if [[ $(contains "${option[@]}" "-r") != "false" ]]
        then
        # Remove remote flag and the remote, as they are not valid git push options
        i=$(contains "${option[@]}" "-r")
        unset option[$i]
        ((i++))
        # Set the remote to be used
        remote="${option[$i]}"
        unset option[$i]
    fi

    # Determine the remote if it is not specified
    if [ -z ${remote} ]
        then
        # Get the upstream repository
        local upstream=$(git rev-parse --abbrev-ref "${branch}"@{upstream})
        IFS='/' read -ra ADDR <<< "$upstream"
        # The first in the array should be the remote
        remote="${ADDR[0]}"
    fi

    # Check if verbose flag is set
    if [[ $(contains "${option[@]}" "-v") != "false" ]] || [[ $(contains "${option[@]}" "--verbose") != "false" ]]
        then
        # Output what to do
        read -p "git push ${option[@]} ${remote} ${branch}"
    fi

    # Perform the actual git push
    git push "${option[@]}" "${remote}" "${branch}"
}
