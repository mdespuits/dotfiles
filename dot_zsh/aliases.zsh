# =================================
# Aliases
# =================================

alias reload="exec $SHELL -l"
alias h="history 0 | grep"

# =================================
# git
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"

# =================================
# files
alias ll="lsd --long"

alias wget='wget -c'

# =================================
# tmux aliases
alias cat="bat"
alias j="z"

# =================================
# tmux aliases
alias tml="tmux list-sessions"
alias tma="tmux -2 attach -t $1"
alias tmk="tmux kill-session -t $1"
alias tms="tmuxinator start $1"
alias osx="reattach-to-user-namespace"

# =================================
# vim aliases
alias svim="MYVIMRC=~/.vimrc.simple vim -u ~/.vimrc.simple"


# =================================
# Functions
# =================================
function hasCmd() {
  local CMD=$1

  which $CMD >/dev/null && [[ "$(which $CMD | grep -ic "not found")" -eq "0" ]]
}


function tmlocal() {
  if hasCmd "tmuxinator"; then
    gem install tmuxinator
  fi
  tmuxinator local
}

# =========================
# FZF Searching
[ -f "$HOME/.zsh/fzf.zsh" ] && source "$HOME/.zsh/fzf.zsh"

export FZF_TMUX_HEIGHT="40%"
export FZF_DEFAULT_COMMAND='ag -U --hidden -g "" --ignore .git --ignore tmp --ignore "*.png" --ignore "*.jpg" --ignore "node_modules" --ignore .bin --ignore .DS_Store --ignore "*.gif"'

# =========================
# Autojumping with z
[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

# =========================
# phpbrew
if [ -f "$HOME/.phpbrew/bashrc" ]; then
  source $HOME/.phpbrew/bashrc
fi

# =========================
# direnv
hasDirenv() {
  return $(hasCmd "direnv")
}

if hasDirenv; then
  eval "$(direnv hook zsh)"
else
  echo "direnv is missing"
fi

# =========================
# asdf
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  source "$HOME/.asdf/asdf.sh"

  # append completions to fpath
  fpath=("${ASDF_DIR}/completions" $fpath)

  # initialise completions with ZSH's compinit
  autoload -Uz compinit
  compinit
fi

# =================================
# chezmoi
alias dote="chezmoi edit"
alias dotd="chezmoi diff"

# =========================
# starship prompt
eval "$(starship init zsh)"

# =========================
# Local config
if [ -f "$HOME/.zshrc.local" ]; then
  source $HOME/.zshrc.local
fi

if hasCmd "bat"; then
  alias cat="bat"
fi

if hasCmd "z"; then
  alias j="z"
fi
