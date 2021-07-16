# Dotfiles

My dotfiles and system configuration handled by [chezmoi](https://www.chezmoi.io).

## Install

Install `chezmoi` and initialize the minimal files


```sh
ASK=1 MINIMAL=1 sh -c "$(curl -fsLS git.io/chezmoi)" -- init mdespuits -S ~/.dotfiles -v
```

```
$ curl -fsLS https://raw.githubusercontent.com/mdespuits/dotfiles/master/install.sh | bash
$ SECRETS=1 bin/chezmoi init
$ make install-bw
$ bw login # and then follow instructions
```

### Apply

```
$ bin/chezmoi apply -v
```

## Tools

* `git`
* `zsh`
* `ctags`
* `editorconfig`
* `asdf`
* `bat`
* `dnsmasq`
* `httpie`
* `vim`
* `jq`
* `lsd`
* `z`
* `git-delta`
* `bitwarden-cli`

## Apps

* Bitwarden
* Docker
* Postgres.app
* Postman
* SequelPro
* VLC
* Workflowy
* Alfred
* Firefox
* Google Chrome
* iTerm2
* Sublime Merge
* Kap
* Vagrant
* Toggl Track
* Vagrant
* Spotify

## Features

* [Starship](https://starship.rs/) prompt
* [direnv](https://direnv.net/)
* [fzf](https://github.com/junegunn/fzf.vim)

## Extras

* [Spicetify](https://github.com/khanhas/spicetify-cli/) to make Spotify a bit more interesting

## Systems supported

* macOS
* ~~Ubuntu~~ **(coming soon!)**

## Prerequisites

**None!** The install script handles major dependencies and configuration needs.
