# dotfiles

These dotfiles are managed by [chezmoi](https://chezmoi.io).

## Layout

- `dot_zshrc`, `dot_tmux.conf`, `dot_gitconfig`: home-directory dotfiles managed directly by chezmoi
- `dot_config/`: application config under `~/.config`, including Neovim and Ghostty
- `dot_oh-my-zsh/custom/themes/`: custom Oh My Zsh theme files
- `run_once_*.sh`: one-time bootstrap hooks that delegate to `install.sh`

## Installation

To install on a new machine, run:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply junousia/dotfiles
```

If you are working directly in this checkout, you can also run:

```sh
./install.sh
```

Or invoke a single setup target:

```sh
./install.sh oh-my-zsh
./install.sh neovim
./install.sh tmux
./install.sh gitconfig
./install.sh ghostty
```

## Chezmoi Helpers

The shell config adds a few helper commands when `chezmoi` is installed:

- `cz`: shorthand for `chezmoi`
- `czs`: show managed-file status
- `czd`: show pending diff
- `cza`: apply changes with verbose output
- `cze <path>`: edit a file through chezmoi
- `czcd`: jump to the chezmoi source directory
- `czedit <path>`: edit a file and immediately apply the result

## Machine-specific configuration

You can add machine-specific configuration by creating a `~/.local_profile` file. It will be sourced by `.zshrc` if it exists.

## Notes

- The repo uses a native chezmoi source layout instead of machine-specific `symlink_*` placeholder files.
- `install.sh` is a convenience bootstrap script for working directly from this checkout.
- `IMPROVEMENTS.md` tracks follow-up cleanup and portability work.
