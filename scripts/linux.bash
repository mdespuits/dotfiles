#!/bin/bash

if [ -n "$PLATFORM" ] && [ "$PLATFORM" = "linux" ]; then
  export CC='/usr/bin/gcc'
  export PATH=$PATH:$HOME/bin:/sbin
fi
