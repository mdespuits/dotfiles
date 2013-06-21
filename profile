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
export PATH=/usr/local/mysql/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.bin:$PATH

# =================================
# General Environment
# =================================

export EDITOR='vi'          # Set vim to be primary editor
export JRUBY_OPTS='--1.9'   # Always prefer Ruby 1.9 in jRuby

# =================================
# Aliases
# =================================

# alias vim="mvim -v"
alias annotate="annotate -p before -e tests" # Annotate alias. Defaults are stupid
alias vi="vim"
alias edit="vi"
alias ..="cd .."
alias ...="cd ../.."
alias empty="cat /dev/null >"
alias back="cd -"
alias be="bundle exec"
alias gs="git s"
alias gd="git d"
alias fastping='ping -c 5 -s 1' # ping really fast ;)
alias ll="ls -la"
alias mkdir="mkdir -pv"
alias ping='ping -c 5' # ping only 5 times
alias s="rspec"
alias t="ruby -Itest"
alias z="zeus"
alias c="clear"
alias wget='wget -c'

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

# =================================
# Rbenv
# =================================
if [ -e "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH";
  if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
  fi
fi


# =================================
# Hub -> Git
# =================================

if which hub > /dev/null; then eval "$(hub alias -s)"; fi
