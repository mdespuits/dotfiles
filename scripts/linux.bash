#!/bin/bash

source "$(dirname $0)/platform.bash"

if [[ $platform == 'linux' ]]; then
  export CC='/usr/bin/gcc'
  export PATH=$PATH:$HOME/bin:/sbin
fi
