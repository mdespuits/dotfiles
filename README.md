# Dotfiles

Dotfiles I have been grooming for quite a while. It has gone through several iterations due to changes in how I manage them.

Currently, I am using [`rcm`](https://github.com/thoughtbot/rcm).

# Install

**Prerequisites**

* Homebrew
* git

**Actions**

    $ cd ~
    $ git clone https://github.com/mattdbridges/dotfiles.git
    $ mv dotfiles .dotfiles
    $ cd .dotfiles
    $ brew bundle --no-upgrade
    $ rcup -x README.md -x Brewfile -x LICENSE -x com.googlecode.iterm2.plist
    $ # to update
    $ rcup -K -x README.md -x LICENSE -x com.googlecode.iterm2.plist
