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
# plugins=()

source $ZSH/oh-my-zsh.sh

###################################
## Now...customize to your pleasure
###################################

# Reload for zsh
alias reload="source ~/.zshrc"

# The name of the shell that is currently in use for shared scripts
# to be smart about what is included.
export SHELL_NAME=zsh

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH

if [ -e "/usr/local/mysql" ]; then
  export PATH="PATH=/usr/local/mysql/bin:$PATH";
fi

export PATH="$HOME/.bin:$PATH"

# Set vim to be primary editor
export EDITOR='vi'

# Always prefer Ruby 1.9 in jRuby
export JRUBY_OPTS='--1.9'

source "$HOME/.scripts/platform.bash"

chmod -R 755 $HOME/.bin;

for file in $HOME/.scripts/**/*; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done
