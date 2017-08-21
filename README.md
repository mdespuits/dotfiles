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
    $ brew install thoughtbot/formulae/rcm
    $ rcup -x README.md -x LICENSE -x com.googlecode.iterm2.plist
    $ # to update
    $ rcup -K -x README.md -x LICENSE -x com.googlecode.iterm2.plist
