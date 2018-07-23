#!/bin/bash

git submodule init
git submodule update

mkdir --parents ${HOME}/.vim/bundle
mkdir --parents ${HOME}/.tmux/plugins

ln -fs "${PWD}/vimrc" "${HOME}/.vimrc"
ln -fs "${PWD}/tmux.conf" "${HOME}/.tmux.conf"
ln -fs "${PWD}/zshrc" "${HOME}/.zshrc"
ln -fs "${PWD}/zsh" "${HOME}/.zsh"
ln -fs "${PWD}/gitconfig" "${HOME}/.gitconfig"
ln -fs "${PWD}/bundle/neobundle.vim" "${HOME}/.vim/bundle/neobundle.vim"
ln -fs "${PWD}/bundle/vimproc.vim" "${HOME}/.vim/bundle/vimproc.vim"
ln -fs "${PWD}/tmux/tpm" "${HOME}/.tmux/plugins/tpm"

pushd ${PWD}/bundle/vimproc.vim
make
$HOME/.vim/bundle/neobundle.vim/bin/neoinstall
