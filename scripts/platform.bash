#!/bin/bash

set_platform() {
  unamestr=$(uname)
  if [[ $unamestr == 'Linux' ]]; then
    PLATFORM='linux'
  elif [[ $unamestr == 'FreeBSD' ]]; then
    PLATFORM='freebsd'
  elif [[ $unamestr == 'Darwin' ]]; then
    PLATFORM='mac'
  else
    PLATFORM='unknown'
  fi
}

# Set platform immediately
set_platform
