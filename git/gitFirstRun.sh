#!/bin/bash

# Setup for git
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitFirstRun {
    templateDir="/home/"$(whoami)"/.git_template"
    if [[ -d ${templateDir} ]]
       then
        echo "Directory is present, no need to create directory"
    else
        echo "Directory is not present, creating directory"
        mkdir ${templateDir}
    fi
 
    cp -R $(dirname "${BASH_SOURCE[0]}")"/template" ${templateDir}
    
    # Changing some global configurations
    git config --global init.templatedir '~/.git_template'
    git config --global core.excludesfile '~/.gitignore'

    # Adding some aliasses
    git config --global alias.a 'add .'
    git config --global alias.st 'status'
    git config --global alias.ct 'commit -F gitCommit.txt'
    git config --global alias.ci 'commit'

    echo "Done"
}
