#!/bin/bash

# Init submodules
git submodule init
git submodule update

# Link in files, replacing whatever's already there.
ln -fs "${PWD}/vimrc" "${HOME}/.vimrc"
ln -fs "${PWD}/emacs" "${HOME}/.emacs"

# Link in directories, removing whatever's already there first.
if [ -e "${HOME}/.elisp" ]; then
    rm -rf "${HOME}/.elisp"
fi
ln -fs "${PWD}/elisp" "${HOME}/.elisp"

mkdir -p ~/.zsh/git-prompt
ln -s ${PWD}/zsh/zsh-git-prompt/gitstatus.py ${HOME}/.zsh/git-prompt/gitstatus.py
ln -s ${PWD}/zshrc ${HOME}/.zshrc
