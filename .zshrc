# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
DOTIFY=$HOME/.dotify
DOTIFY_SCRIPTS=$DOTIFY/scripts

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

# The name of the shell that is currently in use for shared scripts
# to be smart about what is included.
SHELL_NAME=zsh

source $ZSH/oh-my-zsh.sh

###################################
## Now...customize to your pleasure
###################################

# Aliases
if [ -f $HOME/.aliases ]; then
  source $HOME/.aliases
fi

if [[ "$platform" == 'mac' ]]; then
  PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
fi

# Git tab completion
if [ -f $DOTIFY_SCRIPTS/git-completion.bash ]; then
  source $DOTIFY_SCRIPTS/git-completion.bash
fi

source $DOTIFY_SCRIPTS/mdb.shared_exports.sh

# rbenv
eval "$(rbenv init -)"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Hub for github
eval "$(hub alias -s)"
