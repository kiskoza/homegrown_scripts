#!/bin/sh

cd "$(dirname "$0")"

if [ ! -d ~/.git-templates/hooks ]
then
  mkdir -p ~/.git-templates/hooks
fi

cp gitconfig ~/.gitconfig
cp gitignore ~/.gitignore
cp pre-commit ~/.git-templates/hooks
