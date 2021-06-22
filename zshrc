#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

setopt interactivecomments

# Do not accidentally clobber files
setopt noclobber

# Why type 'cd dir' when you can type 'dir'?
setopt AUTO_CD

# Beeps are annoying
setopt NO_BEEP

# Where it gets saved
HISTFILE=~/.zhistory

# Remember about a years worth of history (AWESOME)
SAVEHIST=10000
HISTSIZE=10000

# Pretty    Obvious.  Right?
setopt HIST_REDUCE_BLANKS

# Don't overwrite, append!
setopt APPEND_HISTORY

# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# Save the time and how long a command ran
setopt EXTENDED_HISTORY

# Use Vim mode!
bindkey -v

# Reverse search on the prompt
bindkey '^R' history-incremental-search-backward

# Allow [ or ] wherever you want
unsetopt nomatch

# Add homebrew to the completion path
fpath=("/usr/local/bin/" $fpath)

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# =================================
# PATH info
# =================================

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
if [ -d "/usr/local/heroku/bin" ]; then
  export PATH=/usr/local/heroku/bin:$PATH
fi

# =================================
# MySQL
# =================================
if [ -d "/usr/local/opt/mysql@5.7/bin" ]; then
  export PATH=/usr/local/opt/mysql@5.7/bin:$PATH
fi


# =================================
# Vagrant
# =================================
if [ -d "/Applications/Vagrant/bin" ]; then
  export PATH="/Applications/Vagrant/bin:$PATH"
fi

# =================================
# Postgres.app
# =================================
if [ -d "/Applications/Postgres.app/Contents/Versions/latest/bin" ]; then
  export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
fi

# =================================
# OpenSSL update fix
# =================================
if [ -d "/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt" ]; then
  export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
fi

# =========================
# Composer
# =========================
if [ -d "$HOME/.composer/vendor/bin" ]; then
  export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ]; then
  export PATH=$HOME/go/bin:$PATH
fi

if [ -d "$HOME/.bin" ]; then
  chmod -R 755 $HOME/.bin
  export PATH=$HOME/.bin:$PATH
fi

if [ -d "$HOME/.localbin" ]; then
  chmod -R 755 $HOME/.localbin
  export PATH=$HOME/.localbin:$PATH
fi

# =================================
# General Environment
# =================================

export EDITOR='nvim'
export VISUAL=$EDITOR
export JRUBY_OPTS='--1.9' # Always prefer Ruby 1.9 in jRuby

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
# Aliases
# =================================

alias reload="exec $SHELL -l"
alias vim="nvim"
alias vi="nvim"
alias h="history 0 | grep"

# git
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"

alias fastping='ping -c 1 -s 1' # One. Ping. Only.
alias ll="ls -laih"
alias wget='wget -c'

# tmux aliases
alias tml="tmux list-sessions"
alias tma="tmux -2 attach -t $1"
alias tmk="tmux kill-session -t $1"
alias tms="tmuxinator start $1"
alias osx="reattach-to-user-namespace"

# Better cat
alias cat="ccat"

# =================================
# Functions
# =================================

function tmlocal() {
  if [[ ! "$(which tmuxinator | grep -ic "not found")" -eq "0" ]]; then
    gem install tmuxinator
  fi
  tmuxinator local
}

function who_wrote_this_code() {
  find $1 \( ! -regex '.*/\..*' \) -name '*.rb' -o -name '*.js' -o -name '*.css' -o -name '*.scss' -type f -print -exec git blame '{}' \; | ruby -pe "sub /(^.*\((.*?)\s+2.*$)/, '\2'" | egrep -vE '[[:punct:][:digit:]]' | sort | uniq -c | sort -nr
}

function edit-file() {
  if [[ -d ".git" ]]; then
    code $(git ls-files | fzf)
  else
    code $(fzf)
  fi
}
alias edit='edit-file'

# =========================
# FZF Searching
# =========================
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

export FZF_TMUX_HEIGHT="40%"
export FZF_DEFAULT_COMMAND='ag -U --hidden -g "" --ignore .git --ignore "*.png" --ignore "*.jpg" --ignore "node_modules" --ignore .bin --ignore .DS_Store --ignore "*.gif"'

# =========================
# Autojumping
# =========================
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh

# =========================
# phpbrew
# =========================
if [ -f "$HOME/.phpbrew/bashrc" ]; then
  source $HOME/.phpbrew/bashrc
fi

# =========================
# direnv
# =========================
hasCmd() {
  local CMD=$1

  which $CMD >/dev/null && [[ "$(which $CMD | grep -ic "not found")" -eq "0" ]]
}

hasDirenv() {
  return $(hasCmd "direnv")
}

if hasDirenv; then
  eval "$(direnv hook zsh)"
else
  echo "direnv is missing"
fi

if [ -f "$HOME/.asdf/asdf.sh" ]; then
  source "$HOME/.asdf/asdf.sh"

  # append completions to fpath
  fpath=("${ASDF_DIR}/completions" $fpath)

  # initialise completions with ZSH's compinit
  autoload -Uz compinit
  compinit
fi

eval "$(starship init zsh)"

# Local config
if [ -f "$HOME/.zshrc.local" ]; then
  source $HOME/.zshrc.local
fi
