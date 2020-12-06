#!/bin/bash

backup_and_link() {
  local base=$(basename $1)
  local dir=$(basename $(dirname $1))
  if [[ -L "$HOME/$1" ]]; then
    rm -f "$HOME/$1"
  fi
  if [[ -e "$HOME/$1" ]]; then
    if [[ ! -d "$HOME/.dotbackup/$dir" ]]; then
      echo "make dir $HOME/.dotbackup/$dir"
      mkdir "$HOME/.dotbackup/$dir"
    fi
    mv "$HOME/$1" "$HOME/.dotbackup/$dir"
  fi
  if [[ ! -d "$HOME/$dir" ]]; then
    echo "make dir $HOME/$dir"
    mkdir "$HOME/$dir"
  fi
  ln -snf $dotdir/$1 $HOME/$1
}

if [[ ! -d "$HOME/.dotbackup" ]]; then
  echo "make dir $HOME/.dotbackup"
  mkdir "$HOME/.dotbackup"
fi
scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
dotdir=$(dirname $scriptdir)
if [[ $HOME == $dotdir ]]; then
  echo "home and dotfiles are same"
  exit 1
fi
dotfiles=$(find $dotdir -maxdepth 1)
for dotfilepath in $dotfiles; do
  dotbasename=$(basename $dotfilepath)
  [[ $dotfilepath == $dotdir ]] && continue
  [[ $dotbasename == "README.md" ]] && continue
  [[ $dotbasename == ".git" ]] && continue
  [[ $dotbasename == ".gitignore" ]] && continue
  [[ $dotbasename == ".bin" ]] && continue
  if [[ -d $dotfilepath ]]; then
    dotfiles2=$(find $dotfilepath -maxdepth 1)
    for dotfilepath2 in $dotfiles2; do
      [[ $dotfilepath2 == $dotfilepath ]] && continue
      dotbasename2=$(basename $dotfilepath2)
      echo "$dotbasename/$dotbasename2"
      backup_and_link $dotbasename/$dotbasename2
    done
  else
    echo "$dotbasename"
    backup_and_link $dotbasename
  fi
done
echo "finished"
