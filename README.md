# dotfiles

## Installation

These dotfiles are managed by [chezmoi](https://chezmoi.io).

To install on a new machine, run the following command:

```bash
sh -c "$(curl -fsSL https://get.chezmoi.io/)" -- init --apply junousia/dotfiles
```

This will initialize `chezmoi` with this repository, and apply the dotfiles to your home directory.

## Machine-specific configuration

You can add machine-specific configuration by creating a `~/.local_profile` file. It will be sourced by `.zshrc` if it exists.
