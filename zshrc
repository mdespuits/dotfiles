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

# =================================
# PATH info
# =================================

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
export PATH=/usr/local/heroku/bin:$PATH
export PATH=/usr/local/opt/mysql@5.7/bin:$PATH
export PATH=$HOME/.bin:$PATH
if [[ -d "$HOME/.localbin" ]] ; then
  export PATH=$HOME/.localbin:$PATH
fi

# =================================
# General Environment
# =================================

export EDITOR='nvim'
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
# macOS
# =================================

if [ -d "/Applications/Vagrant/bin" ]; then
  export PATH="/Applications/Vagrant/bin:$PATH"
fi

# Postgres.app: Add bin to path for psql commands
if [ -d "/Applications/Postgres.app/Contents/Versions/9.3/bin" ]; then
  export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"
fi

# OpenSSL update fix
if [ -d "/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt" ]; then
  export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
fi

# =================================
# chruby
# =================================
source /usr/local/opt/chruby/share/chruby/chruby.sh

# =================================
# Aliases
# =================================

alias reload="exec $SHELL -l"
alias vim="nvim"
alias vi="nvim"
alias h="history 0 | grep"
alias be="bundle exec"
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
alias tmlocal="tmuxinator local"
alias osx="reattach-to-user-namespace"

# Better GNU
alias readlink="greadlink"
alias cat="ccat"

# =================================
# Functions
# =================================

function who_wrote_this_code {
  find $1 \( ! -regex '.*/\..*' \) -name '*.rb' -o -name '*.js' -o -name '*.css' -o -name '*.scss' -type f -print -exec git blame '{}' \; | ruby -pe "sub /(^.*\((.*?)\s+2.*$)/, '\2'" | egrep -vE '[[:punct:][:digit:]]' | sort | uniq -c | sort -nr;
}

function edit-file() {
  if [[ -d ".git" ]] ; then
    vim $(git ls-files | fzf)
  else
    vim $(fzf)
  fi
}
alias edit='edit-file'

# Bin files from this repo should be executable
chmod -R 755 $HOME/.bin;

# Hook direnv into ZSH
eval "$(direnv hook zsh)"

# FZF Searching
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_TMUX_HEIGHT="40%"
export FZF_DEFAULT_COMMAND='ag -U --hidden -g "" --ignore .git --ignore "*.png" --ignore "*.jpg" --ignore "node_modules" --ignore .bin --ignore .DS_Store --ignore "*.gif"'

# Autojumping
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -f /usr/local/opt/nvm/nvm.sh ] && . "/usr/local/opt/nvm/nvm.sh"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
