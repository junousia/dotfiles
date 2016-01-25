#!/bin/bash

git submodule init
git submodule update

if [ $# -eq 0 ]; then
  INSTALLDIR=$HOME
else
  INSTALLDIR=$1
fi

ln -fs "${PWD}/vimrc" "${INSTALLDIR}/.vimrc"
ln -fs "${PWD}/tmux.conf" "${INSTALLDIR}/.tmux.conf"
ln -fs "${PWD}/zshrc" "${INSTALLDIR}/.zshrc"
ln -fs "${PWD}/zsh" "${INSTALLDIR}/.zsh"
ln -fs "${PWD}/gitconfig" "${INSTALLDIR}/.gitconfig"

if [ ! -d "${INSTALLDIR}/.vim/bundle" ]; then
    echo "exists"
    mkdir -p $INSTALLDIR/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim $INSTALLDIR/.vim/bundle/neobundle.vim
fi

$INSTALLDIR/.vim/bundle/neobundle.vim/bin/neoinstall
