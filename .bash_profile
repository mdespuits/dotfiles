#!/bin/bash

# Reload for bash
alias reload="source ~/.bash_profile"

export SHELL_NAME=bash

# Adding /url/local/bin for Homebrew
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export DOTIFY_HOME=$HOME/.dotify

# Source all scripts
source $DOTIFY_HOME/scripts.sh

txtcyn='\e[0;36m' # Cyan
txtrst='\e[0m'    # Text Reset

PS1="${txtcyn}\w ${txtrst}\n $ "
PS2='> '
PS4='+ '
