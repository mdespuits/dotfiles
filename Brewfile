# Update Homebrew itself
update

# Update all installed brews
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
install findutils
# Install Bash 4 and ZSH
install bash
install zsh

tap homebrew/dupes

# Essential development packages
install git
install the_silver_searcher
install sqlite
install vim --override-system-vi
install wget

# Languages
install go
install node
install rbenv ruby-build
install rbenv-gem-rehash

# Background services
install memcached
install openssl
install redis

# Extra fun stuff
install jq
install htop-osx
install heroku-toolbelt
install tmux
install tmate
# install tig
install tree
install ssh-copy-id

# To prevent some things from breaking
install unixodbc

# Image processing that might need to happen
install graphviz
install imagemagick

# OSX Apps
tap phinze/cask
install brew-cask

function installcask() {
  cask install "${@}" 2> /dev/null
}

# installcask audacity
# installcask dropbox
# installcask google-chrome
# installcask google-chrome-canary
# installcask iterm2
# installcask jing
# installcask sublime-text
# installcask sequel-pro
# installcask vagrant
# installcask virtualbox
# installcask vlc

# Fun OSX Quick Look plugins
installcask betterzipql
installcask qlcolorcode
installcask qlmarkdown
installcask qlprettypatch
installcask qlstephen
installcask quicklook-csv
installcask quicklook-json
installcask suspicious-package
installcask webp-quicklook
