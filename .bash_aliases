# Global bash aliases
alias ll="ls -lahG"
alias back='cd -'

# Aliases
alias vi="mvim -v"
alias vim="vi"

# Bash-specific aliases
if [ $SHELL_NAME = 'bash' ]; then
  # Reload Bash config
  alias reload="source ~/.bash_profile"

  # Basic backward history search in bash
  bind '"\e[A"':history-search-backward
  bind '"\e[B"':history-search-forward
fi

# ZSH-specific aliases
if [ $SHELL_NAME = 'zsh' ]; then
  # Reload ZSH config
  alias reload="source ~/.zshrc"
fi

# Git Aliases
alias gc="git checkout"
alias gb="git branch"
alias gs="git status"
alias gm="git merge"
alias gd="git diff"
alias gds="git diff --staged"

# Hub aliased to Git
alias git=hub

# Bundler Aliases
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"

# Annotate alias. Defaults are stupid
alias annotate='annotate -p before -e tests'

# System aliases
alias subl='open -a "Sublime Text 2"'

# Rails docs...
alias railsdoc="open ~/code/personal/gems/railsdocs/doc/rdoc/index.html"
