#!/usr/bin/env bash

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

TMP_GNUPG_DIR="$(chezmoi source-path)/.gnupg"

main() {
  if [ $(gpg --list-keys --keyid-format=long | grep -ic "AA59D211400B6FC9") -gt "0" ]; then
    ansi --yellow "GPG keys are already installed"
  else
    mkdir -p $TMP_GNUPG_DIR
    pushd $TMP_GNUPG_DIR

    bw get attachment "trustdb.txt" --itemid "777536fd-671b-4267-a788-ad5c012a7d98"
    bw get attachment "secret-key-backup.asc" --itemid "777536fd-671b-4267-a788-ad5c012a7d98"

    gpg --import $TMP_GNUPG_DIR/secret-key-backup.asc
    gpg --import-ownertrust < $TMP_GNUPG_DIR/trustdb.txt

    popd>/dev/null

    rm -rf $TMP_GNUPG_DIR
  fi
}

main
# vim: ft=sh
