#!/usr/bin/env bash

set -euo pipefail

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly CYAN='\033[0;36m'
readonly BCYAN='\033[1;36m'
readonly NC='\033[0m'

BW_SESSION=${BW_SESSION:-""}

log() {
  local statement="$1"

  echo -e "${CYAN}==> $statement${NC}"
}

announce() {
  local statement="$1"
  echo -e "${BCYAN}==>${NC}${GREEN} $statement${NC}"
}

isavailable() {
  type "$1" &> /dev/null
}

main() {
  # ===============================
  # Homebrew
  # ===============================
  if ! isavailable brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    log "Homebrew already installed"
  fi

  # ===============================
  # Install minimal requirement
  # ===============================
  brew bundle --no-lock --no-upgrade --file=/dev/stdin <<EOF
  brew "git"
  brew "vim"
  brew "chezmoi"
  brew "bitwarden-cli"
  brew "gnupg"
EOF

  # ===============================
  # Initialize dotfiles
  # ===============================
  chezmoi init mdespuits/dotfiles -S ~/.dotfiles
}

main
# vim: ft=sh
