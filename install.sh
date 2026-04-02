#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Define colors
COLOR_RESET="\033[0m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_CYAN="\033[36m"
COLOR_BOLD="\033[1m"

# Ensure local bin exists for optional bootstrap installs
mkdir -p "${HOME}/.local/bin"

# Install chezmoi if missing
if ! command -v chezmoi >/dev/null 2>&1; then
    echo "${COLOR_CYAN}Installing chezmoi...${COLOR_RESET}"
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${HOME}/.local/bin"
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# Update git submodules
git submodule update --init --recursive

create_symlink() {
    local source=$1
    local target=$2
    local backup_target

    mkdir -p "$(dirname "$target")"

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "${COLOR_YELLOW}${target} already points to ${source}${COLOR_RESET}"
        return
    fi

    if [ -L "$target" ] || [ -e "$target" ]; then
        backup_target="${target}.bak"
        if [ -e "$backup_target" ] || [ -L "$backup_target" ]; then
            backup_target="${target}.bak.$(date +%Y%m%d%H%M%S)"
        fi
        echo "${COLOR_YELLOW}Backing up existing ${target}${COLOR_RESET}"
        mv "$target" "$backup_target"
    fi

    ln -sfn "$source" "$target"
    echo "${COLOR_GREEN}Linked ${source} to ${target}${COLOR_RESET}"
}

install_oh_my_zsh() {
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        echo "${COLOR_CYAN}Installing Oh My Zsh...${COLOR_RESET}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        echo "${COLOR_GREEN}Oh My Zsh installed successfully.${COLOR_RESET}"
    else
        echo "${COLOR_YELLOW}Oh My Zsh already installed.${COLOR_RESET}"
    fi

    create_symlink "${SCRIPT_DIR}/dot_zshrc" "${HOME}/.zshrc"
    create_symlink "${SCRIPT_DIR}/dot_oh-my-zsh/custom/themes/junou.zsh-theme" "${HOME}/.oh-my-zsh/custom/themes/junou.zsh-theme"
}

install_neovim() {
    echo "${COLOR_CYAN}Setting up Neovim configuration...${COLOR_RESET}"

    local nvim_bin="${HOME}/local/bin/nvim"
    if [ -x "$nvim_bin" ]; then
        export PATH="${HOME}/local/bin:${PATH}"
    fi

    create_symlink "${SCRIPT_DIR}/dot_config/nvim" "${HOME}/.config/nvim"
    nvim --headless -c 'Lazy! sync' -c 'sleep 20' -c 'qa'

    echo "${COLOR_GREEN}Neovim configuration and plugins setup successfully.${COLOR_RESET}"
}

install_tmux() {
    echo "${COLOR_CYAN}Setting up TMUX configuration...${COLOR_RESET}"

    local tpm_path="${HOME}/.tmux/plugins/tpm"
    if [ ! -d "$tpm_path" ]; then
        echo "${COLOR_YELLOW}TPM not found. Installing...${COLOR_RESET}"
        git clone https://github.com/tmux-plugins/tpm "$tpm_path"
        echo "${COLOR_GREEN}TPM installed successfully.${COLOR_RESET}"
    else
        echo "${COLOR_YELLOW}TPM already installed.${COLOR_RESET}"
    fi

    mkdir -p "${HOME}/.tmux/plugins"
    create_symlink "${SCRIPT_DIR}/dot_tmux.conf" "${HOME}/.tmux.conf"
    "${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh"
    echo "${COLOR_GREEN}TMUX configuration and plugins setup successfully.${COLOR_RESET}"
}

install_gitconfig() {
    echo "${COLOR_CYAN}Setting up git configuration...${COLOR_RESET}"
    create_symlink "${SCRIPT_DIR}/dot_gitconfig" "${HOME}/.gitconfig"
    echo "${COLOR_GREEN}Git configuration setup successfully.${COLOR_RESET}"
}

install_ghostty() {
    echo "${COLOR_CYAN}Setting up Ghostty configuration...${COLOR_RESET}"
    create_symlink "${SCRIPT_DIR}/dot_config/ghostty" "${HOME}/.config/ghostty"
    echo "${COLOR_GREEN}Ghostty configuration setup successfully.${COLOR_RESET}"
}

install_all() {
    echo "${COLOR_BOLD}Starting setup...${COLOR_RESET}"
    install_oh_my_zsh
    install_neovim
    install_tmux
    install_gitconfig
    install_ghostty
    echo "${COLOR_BOLD}${COLOR_GREEN}Setup complete.${COLOR_RESET}"
}

usage() {
    cat <<EOF
Usage: $(basename "$0") [all|oh-my-zsh|neovim|tmux|gitconfig|ghostty]
EOF
}

case "${1:-all}" in
    all)
        install_all
        ;;
    oh-my-zsh)
        install_oh_my_zsh
        ;;
    neovim)
        install_neovim
        ;;
    tmux)
        install_tmux
        ;;
    gitconfig)
        install_gitconfig
        ;;
    ghostty)
        install_ghostty
        ;;
    *)
        usage >&2
        exit 1
        ;;
esac
