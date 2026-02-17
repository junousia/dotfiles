#!/bin/bash

# Exit on error
set -e

# Install chezmoi
if ! command -v chezmoi &>/dev/null; then
    echo "chezmoi could not be found, installing..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Initialize and apply dotfiles
echo "Initializing and applying dotfiles..."
~/.local/bin/chezmoi init --apply https://github.com/junousia/dotfiles.git

echo "Dotfiles installation complete!"
