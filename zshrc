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

# Add homebrew to the completion path
fpath=("/usr/local/bin/" $fpath)

# =================================
# PATH info
# =================================

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
export PATH=/usr/local/heroku/bin:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export PATH=$HOME/.bin:$PATH
if [[ -d "$HOME/.localbin" ]] ; then
  export PATH=$HOME/.localbin:$PATH
fi
export PATH=$PATH:/usr/local/Cellar/mysql55/5.5.30/bin

# =================================
# General Environment
# =================================

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
# Mac OS X
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

# alias annotate="annotate -p before -e tests" # Annotate alias. Defaults are stupid
alias reload="exec $SHELL -l"
alias vi="vim"
alias h="history 0 | grep"
alias be="bundle exec"
alias gs="git status"
alias gd="git diff -w"
alias gds="git diff --staged -w"
alias fastping='ping -c 1 -s 1' # One. Ping. Only.
alias ll="ls -lai"
alias wget='wget -c'

# tmux aliases
alias tml="tmux list-sessions"
alias tma="tmux -2 attach -t $1"
alias tmk="tmux kill-session -t $1"
alias tms="mux start $1"
alias osx="reattach-to-user-namespace"

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

function kill-dnsmasq() {
  sudo kill $(ps aux | grep '[d]nsmasq' | awk '{print $2}')
}

function gif-ify() {
  if [[ -n "$1" && -n "$2" ]]; then
    ffmpeg -i $1 -pix_fmt rgb24 temp.gif
    convert -layers Optimize temp.gif $2
    rm temp.gif
  else
    echo "proper usage: gif-ify <input_movie.mov> <output_file.gif>. You DO need to include extensions."
  fi
}

function taocl() {
  curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md |
    pandoc -f markdown -t html |
    xmlstarlet fo --html --dropdtd |
    xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" |
    xmlstarlet unesc | fmt -80
}

# Bin files from this repo should be executable
chmod -R 755 $HOME/.bin;

# Hook direnv into ZSH
eval "$(direnv hook zsh)"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
