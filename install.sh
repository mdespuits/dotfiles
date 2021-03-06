#!/usr/bin/env bash

set -euo pipefail

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly CYAN='\033[0;36m'
readonly BCYAN='\033[1;36m'
readonly NC='\033[0m'

BW_SESSION=${BW_SESSION:-""}

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=darwin;;
    CYGWIN*)    machine=cygwin;;
    MINGW*)     machine=mingw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

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
  # Install
  # ===============================
  if [ $machine == "linux" ]; then
    sudo apt-get -y install zsh build-essential
    sudo chsh -s $(which zsh) $(whoami)
  fi

  # ===============================
  # Homebrew
  # ===============================
  if ! isavailable brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    log "Follow directions above and then re-run the curl install.sh command"
    exit 0
  else
    log "Homebrew already installed"
  fi

  if ! isavailable jq; then
    # ===============================
    # Install minimal requirement
    # ===============================
    brew install gcc git vim chezmoi bitwarden-cli gnupg jq
  fi

  # ===============================
  # Initialize dotfiles
  # ===============================
  ASK=1 MINIMAL=1 chezmoi init mdespuits/dotfiles -S ~/.dotfiles
}

main
# vim: ft=sh
