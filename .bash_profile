#!/bin/bash

# Reload for bash
alias reload="source ~/.bash_profile"

export SHELL_NAME=bash

export CLICOLOR=1
export TERM=xterm-256color

# Adding /url/local/bin for Homebrew
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH
export DOTIFY_HOME=$HOME/.dotify

# Source all scripts
source $DOTIFY_HOME/setup.sh

# Basic backward history search in bash
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

if [ -n "$PLATFORM" ] && [ "$PLATFORM" = "mac" ]; then
  export PS1='\[\e[0;35m⌘\e[m  \e[0;36m\w/\e[m \e[0;33m`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`\e[m\]'
else
  export PS1='\[\e[0;35m⌘\e[m  \e[0;36m\w/\e[m \e[0;33m`git branch 2> /dev/null | grep -e ^* | sed -e '' s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`\e[m\]'
fi
export PS2='> '
export PS4='+ '
