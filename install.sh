#!/bin/bash

git submodule init
git submodule update

if [ $# -eq 0 ]; then
  INSTALLDIR=$HOME
else
  INSTALLDIR=$1
fi

ln -fs "${PWD}/vimrc" "${INSTALLDIR}/.vimrc"
ln -fs "${PWD}/emacs" "${INSTALLDIR}/.emacs"
ln -fs "${PWD}/tmux.conf" "${INSTALLDIR}/.tmux.conf"
ln -fs "${PWD}/zshrc" "${INSTALLDIR}/.zshrc"
ln -fs "${PWD}/zsh" "${INSTALLDIR}/.zsh"
ln -fs "${PWD}/gitconfig" "${INSTALLDIR}/.gitconfig"
ln -fs "${PWD}/gnupg" "${INSTALLDIR}/.gnupg"
ln -fs "${PWD}/password-store" "${INSTALLDIR}/.password-store"

if [ -e "${INSTALLDIR}/.elisp" ]; then
    rm -rf "${INSTALLDIR}/.elisp"
fi

if [ ! -d "${INSTALLDIR}/.vim/bundle" ]; then
    echo "exists"
    mkdir -p $INSTALLDIR/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim $INSTALLDIR/.vim/bundle/neobundle.vim
fi
