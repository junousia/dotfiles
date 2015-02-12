#!/bin/bash

git submodule init
git submodule update

ln -fs "${PWD}/vimrc" "${HOME}/.vimrc"
ln -fs "${PWD}/emacs" "${HOME}/.emacs"
ln -fs "${PWD}/tmux.conf" "${HOME}/.tmux.conf"
ln -fs "${PWD}/zshrc" "${HOME}/.zshrc"
ln -fs "${PWD}/zsh/oh-my-zsh" "${HOME}/.oh-my-zsh"

if [ -e "${HOME}/.elisp" ]; then
    rm -rf "${HOME}/.elisp"
fi

mkdir -p ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

