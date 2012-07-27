# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
DOTIFY=$HOME/.dotify

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

export SHELL=/bin/zsh

source $ZSH/oh-my-zsh.sh
if [ -f $HOME/.bash_aliases ]; then
  source $HOME/.bash_aliases
fi

# Customize to your needs...

export PATH=/usr/local/bin:$PATH

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export PATH=/Applications/MAMP/Library/bin:$PATH
export PATH=/Applications/MAMP/bin/php/php5.2.17/bin:$PATH
export PATH=/Applications/MAMP/bin/php/php5.3.6/bin:$PATH
export PATH=/usr/local/sbin:$PATH

export BUNDLER_EDITOR='vi'

export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/local/bin:$PATH
eval "$(rbenv init -)"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
