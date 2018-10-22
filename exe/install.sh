#!/bin/bash
# vim: filetype=sh

set -e

# Don't need these right now, but maybe later on
# readonly PROGNAME=`basename $0`
# readonly PROGDIR=`/usr/bin/readlink -n $(dirname $0)`
readonly ARGS="$@"

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

say() {
  local statement=$@

  echo -e "${GREEN}$statement${NC}"
}

say_blue() {
  local statement=$@

  echo -e "${BLUE}$statement${NC}"
}

say_done() {
  say_blue "==> Done!"
}

say_dotfiles_setup() {
  echo -e "${BLUE}==> Dotfiles Setup!!!${NC}"
}

# Command to run shell but with colors!!
run() {
  local cmd=$@

  say "\$ $cmd"
  command $cmd
}

install_homebrew() {
  say "==> Installing Homebrew"
  if ! [ -x "$(command -v brew)" ]; then
    ruby <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
    say_done
  else
    say_blue "==> Homebrew already installed! :)"
  fi
}

install_git() {
  say "==> Installing git"
  if ! [ -x "$(command -v git)" ]; then
    brew install git 2>/dev/null
    say_done
  else
    say_blue "==> git already installed! :)"
  fi
}

clone_repo_to_dotfiles() {
  local dir="$HOME/.dotfiles"

  say "==> Cloning dotfiles repository"
  if [ ! -d $dir ]; then
    git clone https://github.com/mdespuits/dotfiles.git $HOME/.dotfiles
    say_done
  else
    say_blue "==> Already exists."
  fi
}

brew_bundle() {
  say "==> Homebrew Bundling..."
  cd $HOME/.dotfiles && brew bundle --no-upgrade
  say_done
}

setup_dotfiles() {
  say "==> Settings up dotfiles"
  rm -rf $HOME/.rcrc
  ln -s $HOME/.dotfiles/rcrc ~/.rcrc
  rcup
  say_done
}

setup_vim_minpac() {
  say "==> Preparing minpac for Vim"
  mkdir -p ~/.config/nvim/pack/minpac/opt
  rm -f $HOME/.config/nvim/init.vim
  ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
  cd "$HOME/.config/nvim/pack/minpac/opt" &> /dev/null
  if [ ! -d "$HOME/.config/nvim/pack/minpac/opt/minpac" ]; then
    git clone https://github.com/k-takata/minpac.git "$HOME/.config/nvim/pack/minpac/opt"
    say_done
  else
    say_blue "==> Minpac already setup"
  fi
}

setup_localbin() {
  say "==> Adding $HOME/.localbin directory"
  if [ ! -d $HOME/.localbin ]; then
    mkdir $HOME/.localbin >/dev/null 2>&1
    say_done
  else
    say_blue "==> Already setup $HOME/.localbin"
  fi
}

setup_zpresto() {
  if [ ! -e "$HOME/.zprezto" ]; then
    say "==> Installing Prezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" &> /dev/null
    setopt EXTENDED_GLOB
    for rcfile in $(find ~/.zprezto/runcoms | grep -v README.md); do
      if [ ! -f "$HOME/.${rcfile:t}" ]; then
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
      fi
    done
    say_done
  else
    say "==> Updating Prezto..."
    cd "${ZDOTDIR:-$HOME}/.zprezto" &> /dev/null
    git pull >/dev/null 2>&1
    git submodule update >/dev/null 2>&1
    cd - &> /dev/null
    say_done
  fi
}

setup_fonts() {
  say "==> Setup Fonts"
  cp $HOME/.dotfiles/fonts/* $HOME/Library/Fonts
  say_done
}

install_minpac_plugins() {
  say "==> Installing Vim plugins"
  nvim +PackUpdate +q && echo
  say_done
}


main() {
  install_homebrew && echo
  install_git && echo

  clone_repo_to_dotfiles && echo

  brew_bundle && echo
  setup_dotfiles && echo
  setup_vim_minpac && echo
  setup_zpresto && echo
  setup_localbin && echo
  setup_fonts && echo

  install_minpac_plugins && echo

  say_dotfiles_setup
}

main $ARGS
