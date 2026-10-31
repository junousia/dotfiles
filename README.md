# dotfiles

These dotfiles are managed by [chezmoi](https://chezmoi.io).

## Layout

- `dot_zshrc`, `dot_tmux.conf`, `dot_gitconfig.tmpl`: dotfiles managed directly by chezmoi
- `dot_config/`: application config under `~/.config`, including Neovim and Ghostty
- `dot_oh-my-zsh/custom/themes/`: custom Oh My Zsh theme files
- `dot_Documents/dot_PowerShell/`: native Windows PowerShell 7 profile
- `run_once_*.sh.tmpl`: OS-aware one-time setup hooks for optional shell, editor, and tmux plugins

## Requirements

- Git and chezmoi
- On Linux/macOS: curl and zsh to use the supplied shell config; initial apply installs Oh My Zsh
- On native Windows: PowerShell 7; Git Credential Manager is recommended

Neovim configuration is shared across platforms. Linux/macOS also get the zsh,
tmux, and Ghostty configs. WSL is treated as Linux and uses that setup.

## Install

On a new machine, this installs chezmoi, clones the repository, and applies the config:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply junousia/dotfiles
```

On Windows, install chezmoi with winget, then initialize the repo and review it
before applying:

```powershell
winget install twpayne.chezmoi
chezmoi init junousia/dotfiles
chezmoi diff
chezmoi apply
```

If chezmoi is already installed, the equivalent is:

```sh
chezmoi init --apply junousia/dotfiles
```

Review what would change before applying by omitting `--apply` during init, then run `chezmoi diff` and `chezmoi apply`.

## Update

Fetch the latest repository version and apply it:

```sh
chezmoi update
```

To inspect changes without applying them:

```sh
chezmoi diff
```

## Optional tools and plugins

The dotfiles are applied and updated by chezmoi. `install.sh` only installs optional tools' supporting components; it does not create or replace dotfile symlinks. Run it from the chezmoi source directory when needed:

```sh
sh "$(chezmoi source-path)/install.sh" oh-my-zsh
sh "$(chezmoi source-path)/install.sh" neovim
sh "$(chezmoi source-path)/install.sh" tmux
```

The first `chezmoi apply` also runs the included one-time setup hooks. Hooks skip Neovim or tmux plugin setup when the corresponding program is not installed. Install the program later, then run the matching `install.sh` command above.

Windows excludes the POSIX setup hooks, zsh, tmux, and Ghostty files. It applies
the PowerShell 7 profile under `Documents\PowerShell` and sets
`XDG_CONFIG_HOME` so Neovim reads the shared config from `~/.config/nvim`.

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

- `chezmoi apply` is the only way this repo manages dotfiles; do not copy or symlink tracked files manually.
- Machine-specific values and secrets should stay in the untracked `~/.local_profile` or `~/.zshrc.local` files.
