#!/usr/bin/env bash

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

main() {
  if ! isavailable bw; then
    ansi --blue "Installing bitwarden-cli"
    brew install bitwarden-cli
  fi
}

main
# vim: ft=sh
