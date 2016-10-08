#!/bin/bash

fileLoc=$(dirname "${BASH_SOURCE[0]}")

# General functions
. ${fileLoc}/function_md.sh
. ${fileLoc}/function_up.sh
. ${fileLoc}/function_rd.sh
. ${fileLoc}/function_addAlias.sh
. ${fileLoc}/function_rebash.sh
. ${fileLoc}/function_addSite.sh


# Git functions
. ${fileLoc}/git/gitInit.sh
. ${fileLoc}/git/gitClone.sh
. ${fileLoc}/git/gitPush.sh
. ${fileLoc}/git/gitPull.sh
. ${fileLoc}/git/gitBranch.sh
. ${fileLoc}/git/gitFirstRun.sh
# . ${fileLoc}/git/parseGitBranch.sh # Not needed to turn on, function is not actually a good function to use outside of command prompt