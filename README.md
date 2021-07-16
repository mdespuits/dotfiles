# Dotfiles

My dotfiles and system configuration handled by [chezmoi](https://www.chezmoi.io).

## Install

Install `chezmoi` and initialize the minimal files

```sh
sh -c "$(curl -fsLS git.io/chezmoi)"
```


### Initialize dotfiles directory

```sh
ASK=1 MINIMAL=1 bin/chezmoi -- init mdespuits -S ~/.dotfiles -v
```

### Use install helper script

```
$ curl -fsLS https://raw.githubusercontent.com/mdespuits/dotfiles/master/install.sh | bash
```

Follow the Linuxbrew instructions to make sure you have necessary commands available and then
re-login to use ZSH. You can safely run this command multiple times to make sure all steps are
complete.

### Install and login to BitWarden

```
make install-bw && bw login
```

Make sure to add the `BW_SESSION` environment variable before the next step

### Apply

```
$ SECRETS=1 bin/chezmoi apply -v
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
