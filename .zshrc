# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew rails3 rake github)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Reload oh-my-zsh
alias reload="source ~/.zshrc"

# Git Aliases
alias gs="git s"
alias gd="git d"
alias gm="git m"

# Bundler Aliases
alias be="bundle exec"
alias bi="bundle install && rbenv rehash"
alias bu="bundle update && rbenv rehash"

# System aliases
alias vi="mvim -v"
alias vim="vi"
alias ll="ls -lahG"
alias rmdir="rm -rf"
alias subl='open -a "Sublime Text 2"'
alias railsdoc="open ~/code/personal/gems/railsdocs/doc/rdoc/index.html"

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
export PATH=$HOME/local/bin:$PATH
eval "$(rbenv init -)"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
