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
alias wget='wget -c'

function isavailable() {
  type "$1" > /dev/null
}

function ll() {
  local dir=${1:-"."}

  if isavailable exa; then
    exa $dir --long -T -L 1 --icons
  elif isavailable lsd; then
    lsd -lai --long
  else
    ls -laih $dir
  fi
}

# =================================
# autojump to z
alias j="z"

# =================================
# Ruby
alias be="bundle exec"

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
# For cleaner desktop
alias screencast="defaults write com.apple.finder CreateDesktop false; killall Finder"
alias unscreencast="defaults write com.apple.finder CreateDesktop true; killall Finder"


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
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

export FZF_TMUX_HEIGHT="40%"
export FZF_DEFAULT_OPTS="--height 30% --layout=reverse"

if isavailable ag; then
  export FZF_DEFAULT_COMMAND='ag -U --hidden -g "" --ignore .git --ignore tmp --ignore "*.png" --ignore "*.jpg" --ignore "node_modules" --ignore .bin --ignore .DS_Store --ignore "*.gif"'
fi

# =========================
# Autojumping with z
source_if_exists "$(brew --prefix)/etc/profile.d/z.sh"

# =========================
# phpbrew
if [ -f "$HOME/.phpbrew/bashrc" ]; then
  source $HOME/.phpbrew/bashrc
fi

# =========================
# direnv
if isavailable direnv; then
  eval "$(direnv hook zsh)"
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
if isavailable starship; then
  eval "$(starship init zsh)"
fi

# =========================
# Local config
if [ -f "$HOME/.zshrc.local" ]; then
  source $HOME/.zshrc.local
fi

if hasCmd "z"; then
  alias j="z"
fi
