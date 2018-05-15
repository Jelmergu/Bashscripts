#!/bin/bash

function rememberLocation {
  echo ${PWD} > ~/.lastLocation
}

if [ -f ~/.lastLocation ]
    then
    cd "$(head -n 1 ~/.lastLocation)"
fi

