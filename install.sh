#!/bin/sh

set -eu

require_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$1" >&2
        return 1
    fi
}

install_oh_my_zsh() {
    if [ -d "${HOME}/.oh-my-zsh" ]; then
        printf 'Oh My Zsh is already installed.\n'
        return
    fi

    require_command curl
    printf 'Installing Oh My Zsh...\n'
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
        -- --unattended
}

sync_neovim() {
    if ! command -v nvim >/dev/null 2>&1; then
        printf 'Skipping Neovim plugin sync: nvim is not installed.\n'
        return
    fi

    nvim_version=$(nvim --version | sed -n '1s/^NVIM v//p')
    nvim_major=${nvim_version%%.*}
    nvim_minor=${nvim_version#*.}
    nvim_minor=${nvim_minor%%.*}
    case "$nvim_major:$nvim_minor" in
        *[!0-9:]*|:*)
            printf 'Skipping Neovim plugin sync: could not parse nvim version.\n'
            return
            ;;
    esac
    if [ "$nvim_major" -eq 0 ] && [ "$nvim_minor" -lt 11 ]; then
        printf 'Skipping Neovim plugin sync: 0.11 or newer is required (found %s).\n' "$nvim_version"
        return
    fi

    printf 'Syncing Neovim plugins...\n'
    nvim --headless '+Lazy! sync' +qa
}

install_tmux_plugins() {
    if ! command -v tmux >/dev/null 2>&1; then
        printf 'Skipping tmux plugin setup: tmux is not installed.\n'
        return
    fi

    require_command git
    plugin_dir="${HOME}/.tmux/plugins/tpm"
    if [ ! -d "$plugin_dir" ]; then
        printf 'Installing tmux plugin manager...\n'
        mkdir -p "$(dirname "$plugin_dir")"
        git clone https://github.com/tmux-plugins/tpm "$plugin_dir"
    fi

    if [ -x "$plugin_dir/scripts/install_plugins.sh" ]; then
        "$plugin_dir/scripts/install_plugins.sh"
    else
        printf 'TPM install script not found: %s\n' "$plugin_dir" >&2
        return 1
    fi
}

usage() {
    cat <<EOF
Usage: $(basename "$0") [all|oh-my-zsh|neovim|tmux]

Install optional tools and their plugins. Dotfiles themselves are managed by chezmoi.
EOF
}

case "${1:-all}" in
    all)
        install_oh_my_zsh
        sync_neovim
        install_tmux_plugins
        ;;
    oh-my-zsh)
        install_oh_my_zsh
        ;;
    neovim)
        sync_neovim
        ;;
    tmux)
        install_tmux_plugins
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac
