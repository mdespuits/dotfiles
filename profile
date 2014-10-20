#!/bin/bash

# =================================
# Determine the Platform
# =================================

export PLATFORM='unknown'

unamestr=$(uname)
if [[ $unamestr == 'Linux' ]]; then
  export PLATFORM='linux'
elif [[ $unamestr == 'FreeBSD' ]]; then
  export PLATFORM='freebsd'
elif [[ $unamestr == 'Darwin' ]]; then
  export PLATFORM='mac'
fi

# =================================
# PATH info
# =================================

export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/.bin:$PATH
export PATH="$PATH:/usr/local/Cellar/mysql55/5.5.30/bin"

# =================================
# General Environment
# =================================

export EDITOR='vim'     # Giving Sublime Text a shot...
export JRUBY_OPTS='--1.9'   # Always prefer Ruby 1.9 in jRuby

# =================================
# Homebrew Cask Options
# =================================

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# =================================
# Linux
# =================================

if [ -n "$PLATFORM" ] && [ "$PLATFORM" = "linux" ]; then
  export CC='/usr/bin/gcc'
fi

# =================================
# Mac OS X
# =================================

if [ -n "$PLATFORM" ] && [ $PLATFORM = "mac" ]; then
  # Postgres.app: Add bin to path for psql commands
  if [ -d "/Applications/Vagrant/bin" ]; then
    export PATH="/Applications/Vagrant/bin:$PATH"
  fi

  alias dunnet="emacs -batch -l dunnet"

  if [ -d "/Applications/Postgres.app/Contents/Versions/9.3/bin" ]; then
    export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"
  fi

  # OpenSSL update fix
  if [ -d "/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt" ]; then
    export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
  fi

  # Homebrew: Adding /url/local/bin
  export PATH="/usr/local/bin:$PATH"
  export CC='/usr/bin/gcc'
fi

# =================================
# Rbenv
# =================================
if [ -e "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH";
  if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
  fi
fi

# Local config
[[ -f ~/.profile.local ]] && source ~/.profile.local

# =================================
# Hub -> Git
# =================================

# if which hub > /dev/null; then eval "$(hub alias -s)"; fi
