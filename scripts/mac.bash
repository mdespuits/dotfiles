#!/bin/bash

if [ -n "$PLATFORM" ] && [ $PLATFORM = "mac" ]; then
  # Postgres.app: Add bin to path for psql commands
  if [ -d "/Applications/Postgres.app/Contents/MacOS/bin" ]; then
    export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
  fi

  # Homebrew: Adding /url/local/bin
  export PATH="/usr/local/bin:$PATH"
  export CC='gcc-4.2'
fi
