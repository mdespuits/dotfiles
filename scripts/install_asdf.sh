#!/usr/bin/env bash

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

hasAsdfPlugin() {
  local pluginName=$1

  isavailable asdf && [[ "$(asdf plugin list | grep -ic "$pluginName")" -eq "1" ]]
}

installAsdf() {
  local asdf_dir=${HOME}/.asdf

  if ! isavailable asdf; then
    ansi --blue "Installing asdf"
    git clone https://github.com/asdf-vm/asdf.git "${asdf_dir}" --branch v0.8.0
    cd "${asdf_dir}"
    git checkout "$(git describe --abbrev=0 --tags)"
    cd -
  else
    ansi --yellow "asdf already installed"
  fi
}

installAsdfPlugins() {
  local plugins=("deno" "tmux" "php")

  for plugin in "${plugins[@]}"; do
    if ! hasAsdfPlugin "$plugin"; then
      ansi --blue "Installing asdf $plugin plugin"
      asdf plugin add "$plugin"
    else
      ansi --yellow "asdf $plugin plugin installed"
    fi
  done
}

installAsdfTools() {
  if isavailable asdf; then
    ansi --blue "Installing main asdf tools"
    goToDir "$HOME"
    asdf install
    goBackDir
  fi
}

main() {
  ansi --green "Installing asdf and plugins"

  installAsdf
  installAsdfPlugins
  installAsdfTools
}

main
# vim: ft=sh
