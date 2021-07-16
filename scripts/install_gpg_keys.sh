#!/usr/bin/env bash

set -euo pipefail

# Restoring GnuPG keys
#
# To move my GPG from system to system consistently, this script should
# do the trick I've stored the backup.asc file and trust db in attachments
# within my Bitwarden account.
#
# See https://risanb.com/code/backup-restore-gpg-key for a useful summary of how
# I got the idea for automating this process.
#
# You can successfully run
#
#   gpg --delete-secret-key $(chezmoi data | jq '.signingkey' | tr -d \") && gpg --delete-key $(chezmoi data | jq '.signingkey' | tr -d \")
#
# And once that has been done, make a small change to this script (to trigger
# chezmoi change detection) and then run this script to trigger the
#
#   make install-gpg-keys

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

TMP_GNUPG_DIR="$(chezmoi source-path)/.gnupg"

SIGNING_KEY=
SIGNING_KEY=$(chezmoi data | jq '.signingkey' | tr -d \")

BW_GPG_ITEM=
BW_GPG_ITEM=$(chezmoi data | jq '.bitwarden.gpg' | tr -d \")

main() {
  if [ $(gpg --list-keys --keyid-format=long | grep -ic ${SIGNING_KEY}) -eq "0" ]; then
    mkdir -p $TMP_GNUPG_DIR
    pushd $TMP_GNUPG_DIR

    bw get attachment "trustdb.txt" --itemid ${BW_GPG_ITEM}
    bw get attachment "secret-key-backup.asc" --itemid ${BW_GPG_ITEM}

    gpg --import $TMP_GNUPG_DIR/secret-key-backup.asc
    gpg --import-ownertrust < $TMP_GNUPG_DIR/trustdb.txt

    popd>/dev/null

    rm -rf $TMP_GNUPG_DIR
  fi
}

main
# vim: ft=sh
