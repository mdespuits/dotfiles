#!/bin/bash

if [[ $platform == 'linux' ]]; then
  export CC='/usr/bin/gcc'
  export PATH=$PATH:$HOME/bin:/sbin
fi
