#!/bin/bash

# Extention on git init that creates a gitCommit file and a .gitignore file
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitInit {

    if [ -d .git or -f .git ]
        then
        gitExists=true
        tmp=""

        if [ -f .gitignore ]
            then
            tmp=$(cat .gitignore)
        fi
    else
        gitExists=false
    fi
    git init

    gitPath=$(git rev-parse --git-dir)

    cat ${gitPath}/gitIgnoreTemplate.txt > .gitignore
    rm ${gitPath}/gitIgnoreTemplate.txt

    if [[ ${gitExists} == false ]]
        then
        echo "First Commit" > gitCommit.txt
        echo "${PWD}" >> ~/gitrepos.txt
        sort ~/gitrepos.txt | uniq -u > ~/gitrepos.txt
    fi
    
    if [[ ${gitExists} == true ]]
        then
        echo "${tmp}" >> .gitignore
        sort .gitignore | uniq -u > .gitignore
    fi
}