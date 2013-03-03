#!/bin/bash

if [[ $platform == 'mac' ]]; then
  # Adding /url/local/bin for Homebrew
  export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
  export PATH="/usr/local/bin:$PATH"
  export CC='gcc-4.2'
fi
