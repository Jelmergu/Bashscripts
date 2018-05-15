#!/bin/bash

# Setup for git
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitFirstRun {

    local user
    local email
    local choice
    local option=("${@}")

    local templateDir="~/.git_template"

    if [[ $(contains ${option[@]} "-c") == "false" ]]
    then
        read -p "Git username?: " user
        read -p "Git email?: " email

        while [[ -z "${user}" || -z "${email}" ]]
        do
            if [  -z "${user}" ]
            then
                echo "Username can not be empty"
                read -p "Git username?: " user
            fi
            if [ -z "${email}" ]
                then
                echo "email can not be empty"
                read -p "Git email?: " email
            fi
        done

        git config --global user.name "${user}"
        git config --global user.email "${email}"

        # More failsave, discovered this using BashOnWindows
        if [ -d "/home/" ] # *nix filesystems
        then
            templateDir="/home/"$(whoami)"/.git_template"
        elif [ -d "/c/" ] # gitbash filesystem
        then
            templateDir="/c/Users/"$(whoami)"/.git_template"
        fi


        if [ -d ${templateDir} ]
           then
            echo "Directory is present, no need to create directory"
        else
            echo "Directory is not present, creating directory"
            mkdir ${templateDir}
        fi

        cp -R $(dirname "${BASH_SOURCE[0]}")"/template/*" ${templateDir}

        # Changing some global configurations
        git config --global init.templatedir '~/.git_template'
        git config --global core.excludesfile '~/.gitignore'

        read -p "Add usefull aliases? (y/n): " choice
        choice=$(strictChoice "${choice}")
    else
        choice="y"
    fi # contains -c flag for commands only

    if [ "${choice}" == "y" ]
        then
        # Adding some usefull aliasses
        git config --global alias.a 'add -A'
        git config --global alias.st 'status -bs'
        git config --global alias.ct '!git commit -F $(git rev-parse --show-toplevel)/gitCommit.txt'

        git config --global alias.ci 'commit -s'
        git config --global alias.ca '!git a && git ci'
        git config --global alias.cat '!git a && git ct'
        git config --global alias.amend '!git a && git ci --amend'

        git config --global alias.co 'checkout'
        git config --global alias.cm 'checkout master'
        git config --global alias.cd 'checkout develop'

        read -p "Add git flow aliases? (y/n): " choice
        choice=$(strictChoice "${choice}")

        if [ "${choice}" == "y" ]
            then
             # Git flow aliases
            git config --global alias.f 'flow'

            git config --global alias.ff 'flow feature'
            git config --global alias.ffs 'flow feature start'
            git config --global alias.fff 'flow feature finish'
            git config --global alias.ffp 'flow feature publish'
            git config --global alias.ffd 'flow feature delete'

            git config --global alias.fr 'flow release'
            git config --global alias.frs 'flow release start'
            git config --global alias.frf 'flow release finish'
            git config --global alias.frp 'flow release publish'
            git config --global alias.frd 'flow release delete'

            git config --global alias.fh 'flow hotfix'
            git config --global alias.fhs 'flow hotfix start'
            git config --global alias.fhf 'flow hotfix finish'
            git config --global alias.fhp 'flow hotfix publish'
            git config --global alias.fhd 'flow hotfix delete'
        fi
    fi

    echo "Done"
}
