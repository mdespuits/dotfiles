#!/usr/bin/env bash

set -e

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly CYAN='\033[0;36m'
readonly BCYAN='\033[1;36m'
readonly NC='\033[0m'

# shellcheck disable=2155
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# shellcheck disable=2155
readonly DOTFILES_PATH="$(dirname $DIR)"

BW_SESSION=${BW_SESSION:-""}

log() {
  local statement="$1"

  echo -e "${CYAN}==> $statement${NC}"
}

announce() {
  local statement="$1"
  echo -e "${BCYAN}==>${NC}${GREEN} $statement${NC}"
}

hasHomebrew() {
  which brew >/dev/null && [[ "$(which brew | grep -ic "not found")" -eq "0" ]]
}

installHomebrew() {
  if ! hasHomebrew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
     log "Homebrew already installed"
  fi
}

installChezmoi() {
  sh -c "$(curl -fsLS git.io/chezmoi)"
}

installMinimumRequirements() {
  brew install git bitwarden-cli gnupg --quiet
}

loginToBitwarden() {
  log "Logging into Bitwarden"

  bw logout 1>/dev/null 2>&1

  if [[ "$(bw login 2>&1 | grep -ic "You are already logged in")" -eq "0" ]]; then
    bw login

    echo -n "What is the Bitwarden session value: "
    read -r BW_SESSION
  else
    log "Already logged in to Bitwarden"
  fi
}

applyChezmoi() {
  log "chezmoi init"
  BW_SESSION=$BW_SESSION bin/chezmoi init mdespuits/dotfiles -S ~/.dotfiles

  log "chezmoi apply tool-versions"
  BW_SESSION=$BW_SESSION bin/chezmoi apply ~/.tool-versions -S ~/.dotfiles

  BW_SESSION=$BW_SESSION bin/chezmoi apply -k -S ~/.dotfiles
}

main() {
  installHomebrew
  installChezmoi
  installMinimumRequirements

  loginToBitwarden

  applyChezmoi
}

main
# vim: ft=sh
