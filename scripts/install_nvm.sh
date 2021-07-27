#!/usr/bin/env bash

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

main() {
  if [ ! -d "$HOME/.config/nvm" ]; then
    ansi --blue "Installing nvm"
    XDG_CONFIG_HOME="$HOME/.config/nvm" curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  fi

}

main
# vim: ft=sh
