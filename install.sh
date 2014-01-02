#!/bin/sh

for name in *; do
  target="$HOME/.$name"
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      echo "WARNING: $target exists but is not a symlink."
    fi
  else
    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'uninstall.sh' ]; then
      echo "Creating $target"
      ln -s "$PWD/$name" "$target"
    fi
  fi
done

if [ ! -e "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh &> /dev/null
fi

if [ ! -e "$HOME/.vim/bundle/vundle" ]; then
  echo "Installing Vundle..."
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle &> /dev/null
fi

echo "Installing vim bundles...";
vim -e -s -u ~/.vimrc.bundles +BundleInstall +qa

echo "Done!"
