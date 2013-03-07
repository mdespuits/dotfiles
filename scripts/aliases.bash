#!/bin/bash

if [[ $platform == 'mac' ]]; then
  alias vim="mvim -v"
fi

alias vi="vim"
alias ...="../.."
alias back="cd -"
alias be="bundle exec"
alias mkdir="mkdir -p"
alias s="rspec"
alias t="ruby -Itest"
alias z="zeus"

# Annotate alias. Defaults are stupid
alias annotate="annotate -p before -e tests"

alias postgres_fix="sudo sysctl -w kern.sysv.shmall=65536 && sudo sysctl -w kern.sysv.shmmax=16777216"
