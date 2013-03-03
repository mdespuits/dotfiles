#!/bin/bash

unamestr=$(uname)

if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ $unamestr == 'Darwin' ]]; then
  platform='mac'
else
  platform='unknown'
fi

