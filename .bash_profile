#!/bin/bash

# Reload for bash
alias reload="source ~/.bash_profile"

export SHELL_NAME=bash

# Adding /url/local/bin for Homebrew
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export DOTIFY_HOME=$HOME/.dotify
export DOTIFY_SCRIPTS=$DOTIFY_HOME/scripts

for file in $DOTIFY_SCRIPTS/*; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done

txtcyn='\e[0;36m' # Cyan
txtrst='\e[0m'    # Text Reset

PS1="${txtcyn}\w ${txtrst}\n $ "
PS2='> '
PS4='+ '

# Rbenv with Homebrew
eval "$(rbenv init -)"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Hub for github
eval "$(hub alias -s)"
