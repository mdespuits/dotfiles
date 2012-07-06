# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

# Example aliases
alias reload="source ~/.zshrc"
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew rails3 rake github)

source $ZSH/oh-my-zsh.sh

function git_current_branch() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///'
}

# Customize to your needs...

# Git Aliases
alias gs="git s"
alias gd="git d"
alias gm="git m"

# Bundler Aliases
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"

# System aliases
alias vi="mvim -v"
alias vim="vi"
alias ll="ls -lahG"
alias rmdir="rm -rf"
alias subl='open -a "Sublime Text 2"'
alias railsdoc="open ~/code/personal/gems/railsdocs/doc/rdoc/index.html"

# Git tab completion
# if [ -f `brew --prefix`/etc/bash_completion ]; then
#   . `brew --prefix`/etc/bash_completion
# fi

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
# export rvm_cd_complete_flag=1
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH=/usr/local/bin:$PATH

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export PATH=/Applications/MAMP/Library/bin:$PATH
export PATH=/Applications/MAMP/bin/php/php5.2.17/bin:$PATH
export PATH=/Applications/MAMP/bin/php/php5.3.6/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=./cake/console:$PATH
export PATH=~/code/dotfiles/shells:$PATH

export BUNDLER_EDITOR='open -a "Sublime Text 2"'
export SOURCE_ANNOTATION_DIRECTORES='spec'

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
export PATH=$HOME/local/bin:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
