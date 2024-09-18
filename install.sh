#!/bin/bash

# Define colors
COLOR_RESET="\033[0m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_CYAN="\033[36m"
COLOR_RED="\033[31m"
COLOR_BOLD="\033[1m"

# Update git submodules
git submodule update --init --recursive

# Helper function to create symbolic links
create_symlink() {
  local source=$1
  local target=$2
  if [ -e "$target" ]; then
    echo -e "${COLOR_YELLOW}Backing up existing ${target}${COLOR_RESET}"
    mv "$target" "${target}.bak"
  fi
  ln -fs "$source" "$target"
  echo -e "${COLOR_GREEN}Linked ${source} to ${target}${COLOR_RESET}"
}

# Install Oh My Zsh and setup zshrc
install_oh_my_zsh() {
  if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    echo -e "${COLOR_CYAN}Installing Oh My Zsh...${COLOR_RESET}"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${COLOR_GREEN}Oh My Zsh installed successfully.${COLOR_RESET}"
  else
    echo -e "${COLOR_YELLOW}Oh My Zsh already installed.${COLOR_RESET}"
  fi
  create_symlink "${PWD}/zshrc" "${HOME}/.zshrc"
}

# Install Neovim and setup configuration
install_neovim() {
  echo -e "${COLOR_CYAN}Setting up Neovim configuration...${COLOR_RESET}"

  # Update PATH if necessary
  local nvim_bin="${HOME}/local/bin/nvim"
  if [ -x "$nvim_bin" ]; then
    export PATH="${HOME}/local/bin:$PATH"
  fi

  mkdir -p "${HOME}/.config/nvim"
  create_symlink "${PWD}/init.lua" "${HOME}/.config/nvim/init.lua"

  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  echo -e "${COLOR_GREEN}Neovim configuration and plugins setup successfully.${COLOR_RESET}"
}

# Install TMUX and setup configuration
install_tmux() {
  echo -e "${COLOR_CYAN}Setting up TMUX configuration...${COLOR_RESET}"

  mkdir -p "${HOME}/.tmux/plugins"
  create_symlink "${PWD}/tmux/tpm" "${HOME}/.tmux/plugins/tpm"
  create_symlink "${PWD}/tmux.conf" "${HOME}/.tmux.conf"
  ensure_tmux_conf
  "${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh"
  echo -e "${COLOR_GREEN}TMUX configuration and plugins setup successfully.${COLOR_RESET}"
}

# Ensure tmux.conf includes TPM configuration
ensure_tmux_conf() {
  local tmux_conf="${HOME}/.tmux.conf"
  if ! grep -q "tmux-plugins/tpm" "$tmux_conf"; then
    echo -e "${COLOR_CYAN}Updating ${tmux_conf} with TPM configuration...${COLOR_RESET}"
    cat <<EOL >> "$tmux_conf"

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOL
    echo -e "${COLOR_GREEN}TPM configuration added to ${tmux_conf}.${COLOR_RESET}"
  else
    echo -e "${COLOR_YELLOW}TPM configuration already present in ${tmux_conf}.${COLOR_RESET}"
  fi
}

# Install git configuration
install_gitconfig() {
  echo -e "${COLOR_CYAN}Setting up git configuration...${COLOR_RESET}"
  create_symlink "${PWD}/gitconfig" "${HOME}/.gitconfig"
  echo -e "${COLOR_GREEN}Git configuration setup successfully.${COLOR_RESET}"
}

# Main function to run all setup tasks
main() {
  echo -e "${COLOR_BOLD}Starting setup...${COLOR_RESET}"
  install_oh_my_zsh
  install_neovim
  install_tmux
  install_gitconfig
  echo -e "${COLOR_BOLD}${COLOR_GREEN}Setup complete.${COLOR_RESET}"
}

# Run the main function
main

