#!/bin/sh

for name in *; do
  target="$HOME/.$name"
  if [ -e "$target" ] && [ -L "$target" ]; then
    echo "Removing $target";
    rm -rf "$target";
  fi
done

if [ -e "$HOME/.oh-my-zsh" ]; then
  echo "Removing oh-my-zsh";
  rm -rf ~/.oh-my-zsh
fi

rm -rf "$HOME/Brewfile"

echo "Removing bundles from vundle";
for bundle in "$PWD/vim/bundle/*"; do
  rm -rf $bundle;
done
rm -rf "$PWD/vim/bundle/.vundle";
