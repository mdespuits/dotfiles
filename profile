#!/bin/zsh

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

export PATH=/usr/local/heroku/bin:$PATH
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/.bin:$PATH
export PATH=$PATH:/usr/local/Cellar/mysql55/5.5.30/bin

# =================================
# General Environment
# =================================

bindkey -v # Use Vim mode!
bindkey '^R' history-incremental-search-backward
export EDITOR='vim'
export VISUAL=$EDITOR
export JRUBY_OPTS='--1.9'   # Always prefer Ruby 1.9 in jRuby

# =================================
# Homebrew Cask Options
# =================================

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# =================================
# Compiler options
# =================================
#
# Previously, OS X did not have an up-to-date
# version of the gcc compiler. As of Yosemite,
# it now provides the only compiler that will
# compile the latest versions of Ruby.
# =================================

export CC='/usr/bin/gcc'

# =================================
# Linux
# =================================

# Nothing currently.

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

# if which hub > /dev/null; then eval "$(hub alias -s)"; fi

# =================================
# Aliases
# =================================

alias annotate="annotate -p before -e tests" # Annotate alias. Defaults are stupid
alias vi="vim"
alias ..="cd .."
alias ...="cd ../.."
alias empty="cat /dev/null >"
alias h="history 0 | grep"
alias back="cd -"
alias be="bundle exec"
alias g="git"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias fastping='ping -c 5 -s 1' # ping really fast ;)
alias ll="ls -lai"
alias mkdir="mkdir -pv"
alias ping='ping -c 5' # ping only 5 times
alias wget='wget -c'

# tmux aliases
alias tml="tmux list-sessions"
alias tma="tmux -2 attach -t $1"
alias tmk="tmux kill-session -t $1"

# =================================
# Functions
# =================================

function prepend() {
  echo $1|cat - $2 > /tmp/out && mv /tmp/out $2
}

function who_wrote_this_code {
  find $1 \( ! -regex '.*/\..*' \) -name '*.rb' -type f -print -exec git blame '{}' \; | ruby -pe "sub /(^.*\((.*?)\s+2.*$)/, '\2'" | egrep -vE '[[:punct:][:digit:]]' | sort | uniq -c | sort -nr;
}

function edit-file() {
  if [[ -d ".git" ]] ; then
    vim $(git ls-files | pick)
  else
    vim $(find . -type f | pick)
  fi
}
alias edit='edit-file'

function hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'

function gif-ify() {
  if [[ -n "$1" && -n "$2" ]]; then
    ffmpeg -i $1 -pix_fmt rgb24 temp.gif
    convert -layers Optimize temp.gif $2
    rm temp.gif
  else
    echo "proper usage: gif-ify <input_movie.mov> <output_file.gif>. You DO need to include extensions."
  fi
}
