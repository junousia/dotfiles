#!/bin/bash

git submodule init
git submodule update

ln -fs "${PWD}/vimrc" "${HOME}/.vimrc"
ln -fs "${PWD}/emacs" "${HOME}/.emacs"
ln -fs "${PWD}/vim" "${HOME}/.vim"

if [ -e "${HOME}/.elisp" ]; then
    rm -rf "${HOME}/.elisp"
fi

ln -fs "${PWD}/elisp" "${HOME}/.elisp"

mkdir -p ~/.zsh/git-prompt
ln -s ${PWD}/zsh/zsh-git-prompt/gitstatus.py ${HOME}/.zsh/git-prompt/gitstatus.py
ln -s ${PWD}/zshrc ${HOME}/.zshrc
