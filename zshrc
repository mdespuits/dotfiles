# completion
autoload -U compinit
compinit

setopt autocd autopushd

alias reload="source ~/.zshrc"

# source "$HOME/.scripts/git-completion.bash"
source "$HOME/.profile"

# Source local config file if it exists
if [ -e "$HOME/.local" ]; then
  source "$HOME/.local"
fi

# Bin files from this repo should be executable
chmod -R 755 $HOME/.bin;
