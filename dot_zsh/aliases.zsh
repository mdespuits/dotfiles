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
  type "$1" >/dev/null
}

function ll() {
  local dir=${1:-"."}

  if isavailable lsd; then
    lsd -lai --long
  else
    ls -laih $dir
  fi
}

if isavailable exa; then
  alias ll="exa  --long --icons -T -L 1 -a"
  alias llT="exa --long --icons -T -L 3 -a"
fi

# =================================
# autojump to z
alias j="z"

# =================================
# Ruby
alias be="bundle exec"
# alias r="bundle exec rails"

# =================================
# tmux aliases
alias tml="tmux list-sessions"
alias tma="tmux -2 attach-session -t"
alias tmk="tmux kill-session -t"
alias tms="tmuxinator start"
alias osx="reattach-to-user-namespace"

# =================================
# node aliases
alias pn="pnpm"

# =================================
# frum aliases
alias fminit='eval "$(frum init)"'
alias fml='frum local'
alias fmu="frum uninstall"
alias fmv="frum versions"

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
source_if_exists "$HOME/.phpbrew/bashrc"

# =========================
# direnv
if isavailable direnv; then
  eval "$(direnv hook zsh)"
fi

if isavailable frum; then
  eval "$(frum init)"
fi

# =================================
# chezmoi
alias dote="chezmoi edit"
alias dotd="chezmoi diff"

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
# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" # This loads nvm completion

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
