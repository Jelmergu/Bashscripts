#!/bin/bash

function rememberLocation {
  echo ${PWD} > ~/.lastLocation
}

if [ -f ~/.lastLocation ]
    then
    alias lastLocation='cd "$(head -n 1 ~/.lastLocation)"'
fi

