#!/bin/bash

# if [ -n "$PLATFORM" ] && [ "$PLATFORM" = "mac" ]; then
#   alias vim="mvim -v"
# fi
#
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

# Annotate alias. Defaults are stupid
alias annotate="annotate -p before -e tests"

alias postgres_fix="sudo sysctl -w kern.sysv.shmall=65536 && sudo sysctl -w kern.sysv.shmmax=16777216"
