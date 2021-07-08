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

# Test if $1 is available
isavailable() {
  type "$1" &>/dev/null
}

installHomebrew() {
  if ! isavailable brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    log "Homebrew already installed"
  fi
}

installChezmoi() {
  sh -c "$(curl -fsLS git.io/chezmoi)"
}

initChezmoi() {
  log "chezmoi init"
  BW_SESSION=$BW_SESSION bin/chezmoi init ~/.dotfiles-test -S ~/.dotfiles -v
}

applyChezmoi() {
  log "chezmoi apply all"
  BW_SESSION=$BW_SESSION bin/chezmoi apply -k -v
}

main() {
  installChezmoi
  initChezmoi
}

main
# vim: ft=sh
