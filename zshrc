[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

# Set the default plugin repo to be zsh-utils
antigen use belak/zsh-utils

# Specify completions we want before the completion module
antigen bundle zsh-users/zsh-completions

# Specify plugins we want
antigen bundle editor
antigen bundle history
antigen bundle prompt
antigen bundle utility
antigen bundle completion

# Specify additional external plugins we want
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle postmodern/chruby share/chruby/chruby.sh
antigen bundle postmodern/chruby share/chruby/auto.sh

# Load everything
antigen apply

# Set any settings or overrides here
# antigen theme candy
prompt belak
bindkey -e

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
export PATH=/usr/local/heroku/bin:$PATH
export PATH=/usr/local/opt/mysql@5.7/bin:$PATH
export PATH=$HOME/.bin:$PATH

if [[ -d "$HOME/go/bin" ]] ; then
  export PATH=$HOME/go/bin:$PATH
fi

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

if which nvim &>/dev/null; then
  alias vim="nvim"
  alias vi="nvim"
fi

alias reload="exec $SHELL -l"
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
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
