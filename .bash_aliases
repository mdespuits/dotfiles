# Global bash aliases
alias ll="ls -lahG"
alias back='cd -'

# Aliases
alias vi="mvim -v"
alias vim="vi"

if [ $SHELL = '/bin/bash' ]; then
  # Reload Bash
  alias reload="source ~/.bash_profile"

  # Backward history search in bash
  bind '"\e[A"':history-search-backward
  bind '"\e[B"':history-search-forward
fi

if [ $SHELL = '/bin/zsh' ]; then
  # Reload ZSH
  alias reload="source ~/.zshrc"
fi

# Git Aliases
alias gc="git checkout"
alias gb="git branch"
alias gs="git status"
alias gm="git merge"
alias gd="git diff"
alias gds="git diff --staged"

# Bundler Aliases
alias be="bundle exec"
alias bi="bundle install && rbenv rehash"
alias bu="bundle update && rbenv rehash"

# Annotate alias. Defaults are stupid
alias annotate='annotate -p before -e tests'

# System aliases
alias subl='open -a "Sublime Text 2"'

# Rails docs...
alias railsdoc="open ~/code/personal/gems/railsdocs/doc/rdoc/index.html"
