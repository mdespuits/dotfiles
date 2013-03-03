#!/bin/bash

# alias ls="ls -Flb"
# alias psx='ps -e | grep $1'
alias back='cd -'
alias ll="ls -lahG"
alias h='history'

# Bundler Aliases
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"

# Git Aliases
alias gc="git checkout"
alias gb="git branch"
alias gs="git status"
alias gm="git merge"
alias gd="git diff"
alias gds="git diff --staged"

# Screencasting
alias hideDesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showDesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Annotate alias. Defaults are stupid
alias annotate='annotate -p before -e tests'

# Rails docs...
alias railsdoc="open ~/Sites/personal/gems/railsdocs/doc/rdoc/index.html"

alias postgres_fix="sudo sysctl -w kern.sysv.shmall=65536 && sudo sysctl -w kern.sysv.shmmax=16777216"

alias mv='mv -i'
# -> Prevents accedentally clobbering files
alias mkdir='mkdir -p'
alias j='jobs -l'

# Usually want egrep
# alias grep="egrep"

# Aliases
if [[ $platform == 'mac' ]]; then
  alias vim="mvim -v"
fi

alias vi="vim"

# Bash-specific aliases
if [ $SHELL_NAME = 'bash' ]; then
  # Basic backward history search in bash
  bind '"\e[A"':history-search-backward
  bind '"\e[B"':history-search-forward
fi
