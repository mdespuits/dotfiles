# load completion functions
fpath=(~/.zsh/completion $fpath)

# Completion
autoload -U compinit
compinit -i

if [ -d ~/.zsh/functions ]; then
  for function in ~/.zsh/functions/*; do
    source $function
  done
fi

# Enter directories without cd
setopt auto_cd

# Expand functions in the prompt
setopt prompt_subst

# Ignore duplicates in history entries
setopt histignoredups

# Enable extended globbing
setopt EXTENDED_GLOB

# Keep TONS of history
export HISTSIZE=4096

alias reload="source ~/.zshrc"

# source "$HOME/.scripts/git-completion.bash"
source "$HOME/.profile"

# Source local config file if it exists
if [ -e "$HOME/.local" ]; then
  source "$HOME/.local"
fi

# Aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Bin files from this repo should be executable
chmod -R 755 $HOME/.bin;
