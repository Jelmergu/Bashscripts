!/bin/bash

# Extention on git init that creates a gitCommit file and a .gitignore file
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitInit {

    local gitExists=false
    local gitDir=""
    local tmp=""
    local option=("${@}")

    if [[ -d .git  ||  -f .git ]]
    then
        gitExists=true
        tmp=""

        if [ -f $(git rev-parse --show-toplevel)/.gitignore ]
        then
            gitDir=$(git rev-parse --show-toplevel)
            tmp=$(cat ${gitDir}/.gitignore)
        fi
    else
        gitExists=false
    fi

    git init

    local gitPath=$(git rev-parse --git-dir)

    if [ -e ${gitPath}/gitIgnoreTemplate.txt ]
    then
        cat ${gitPath}/gitIgnoreTemplate.txt > .gitignore
        rm ${gitPath}/gitIgnoreTemplate.txt
    fi

    if [ ${gitExists} == false ]
    then
        echo "First Commit" > gitCommit.txt
    fi

    if [ ${gitExists} == true ]
    then
        echo "${tmp}" >> .gitignore
        if [ $(contains "${option[@]}" "--ignore-gitignore") != false ]
        then
            echo "$(sort -u ${gitDir}/.gitignore)" > ${gitDir}/.gitignore
        fi
    fi

    echo "${PWD}" >> ~/gitrepos.txt
    echo "$(sort -u ~/gitrepos.txt)" > ~/gitrepos.txt
}