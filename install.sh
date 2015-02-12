#!/bin/bash

git submodule init
git submodule update

ln -fs "${PWD}/vimrc" "${HOME}/.vimrc"
ln -fs "${PWD}/emacs" "${HOME}/.emacs"
ln -fs "${PWD}/tmux.conf" "${HOME}/.tmux.conf"

if [ -e "${HOME}/.elisp" ]; then
    rm -rf "${HOME}/.elisp"
fi

mkdir -p ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

ln -fs ${PWD}/zsh/ ${HOME}/.zsh
ln -fs ${PWD}/zshrc ${HOME}/.zshrc
