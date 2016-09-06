#!/bin/bash

git submodule init
git submodule update

if [ ! -d "${HOME}/.vim/bundle" ]; then
    mkdir -p ${HOME}/.vim/bundle
fi

ln -fs "${PWD}/vimrc" "${HOME}/.vimrc"
#ln -fs "${PWD}/tmux.conf" "${HOME}/.tmux.conf"
ln -fs "${PWD}/zshrc" "${HOME}/.zshrc"
ln -fs "${PWD}/zsh" "${HOME}/.zsh"
ln -fs "${PWD}/gitconfig" "${HOME}/.gitconfig"
ln -fs "${PWD}/bundle/neobundle.vim" "${HOME}/.vim/bundle/neobundle.vim"

$HOME/.vim/bundle/neobundle.vim/bin/neoinstall
