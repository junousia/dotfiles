# Neovim configuration

This is a personal [LazyVim](https://www.lazyvim.org/) setup managed by chezmoi.
It is shared across Linux, macOS, and native Windows with PowerShell 7.

## Requirements

- Neovim 0.11 or newer
- Git
- A C compiler is recommended for native Treesitter parsers

On Windows, the PowerShell profile sets `XDG_CONFIG_HOME` to `~/.config`, so
Neovim uses this same configuration directory as it does on Unix-like systems.

## Local customizations

- `lua/config/`: editor options, keymaps, autocmds, and Lazy.nvim setup
- `lua/plugins/`: plugin specs and overrides
- `lazyvim.json`: enabled LazyVim extras
- `lazy-lock.json`: pinned plugin revisions

After changing plugin specs, run `:Lazy sync` in Neovim. Use `:Mason` to manage
language servers, formatters, and debuggers installed through Mason.
