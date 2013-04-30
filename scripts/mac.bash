#!/bin/bash

if [ -n "$PLATFORM" ] && [ $PLATFORM = "mac" ]; then
  # Postgres.app: Add bin to path for psql commands
  if [ -d "/Applications/Vagrant/bin" ]; then
    export PATH="/Applications/Vagrant/bin:$PATH"
  fi

  if [ -d "/Applications/Postgres.app/Contents/MacOS/bin" ]; then
    export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
  fi

  # OpenSSL update fix
  if [ -d "/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt" ]; then
    export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
  fi

  # Homebrew: Adding /url/local/bin
  export PATH="/usr/local/bin:$PATH"
  export CC='gcc-4.2'
fi
