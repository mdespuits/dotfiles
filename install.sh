#!/usr/bin/env bash

set -euo pipefail

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

initChezmoi() {
  log "chezmoi init"
  BW_SESSION=$BW_SESSION bin/chezmoi init mdespuits/dotfiles -S ~/.dotfiles -v

  log "chezmoi apply tool-versions"
  BW_SESSION=$BW_SESSION bin/chezmoi apply ~/.tool-versions -v --force
}

applyChezmoi() {
  log "chezmoi apply all"
  BW_SESSION=$BW_SESSION bin/chezmoi apply -k -S ~/.dotfiles -v
}

main() {
  installChezmoi
  installMinimumRequirements

  pushd "$(bin/chezmoi source-path)" &> /dev/null
  # make install-bw

  initChezmoi

  popd &> /dev/null

  vim +PlugInstall +qall

  # applyChezmoi
}

main
# vim: ft=sh
