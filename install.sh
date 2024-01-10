#!/bin/bash

git submodule update --init --recursive

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
ln -fs "${PWD}/zshrc" "${HOME}/.zshrc"

# Install TMUX plugins
mkdir -p ${HOME}/.tmux/plugins
ln -fs "${PWD}/tmux/tpm/" "${HOME}/.tmux/plugins/"
ln -fs "${PWD}/tmux.conf" "${HOME}/.tmux.conf"
${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh

# Install Vim plugins
ln -fs "${PWD}/vimrc" "${HOME}/.vimrc"
mkdir -p ${HOME}/.vim/autoload
curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# Install NVim config
mkdir -p ${HOME}/.config/nvim
ln -fs "${PWD}/init.vim" "${HOME}/.config/nvim/init.vim"

# Git configuration
ln -fs "${PWD}/gitconfig" "${HOME}/.gitconfig"
