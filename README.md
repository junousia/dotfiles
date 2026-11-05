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

The dotfiles are applied and updated by chezmoi. `install.sh` installs the locked Nix tool environment and optional tools' supporting components; it does not create or replace dotfile symlinks. Run it from the chezmoi source directory when needed:

```sh
sh "$(chezmoi source-path)/install.sh" oh-my-zsh
sh "$(chezmoi source-path)/install.sh" neovim
sh "$(chezmoi source-path)/install.sh" tmux
```

The first `chezmoi apply` also runs the included one-time setup hooks. Hooks skip Neovim or tmux plugin setup when the corresponding program is not installed. Install the program later, then run the matching `install.sh` command above.

The Nix CLI tools are defined in `flake.nix` and pinned by `flake.lock` as one
package environment. Run `sh "$(chezmoi source-path)/install.sh" nix` to install
or update that environment in a dedicated Nix profile at
`${XDG_STATE_HOME:-~/.local/state}/nix/profiles/chezmoi-tools`. The installer
builds the complete package set before switching the profile; zsh and Fish add
its binaries to PATH. Existing packages in your default Nix profile are preserved.
To update the pinned
Nixpkgs revision, run `nix --extra-experimental-features 'nix-command flakes' flake update`
from the chezmoi source directory, review the lock-file change, then run the
installer again.

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

## Fish alternative

The Fish config is a separate, plugin-free interactive setup. It uses the same
minimal prompt as the zsh theme: magenta username, blue current directory, a
`»` prompt, and a red right-side exit status when a command fails. Fish's built-in
autosuggestions, syntax highlighting, and completions are left at their defaults.
When fzf is installed, its Fish integration enables the usual Ctrl-R history,
Ctrl-T file, and Alt-C directory pickers.

Run `sh "$(chezmoi source-path)/install.sh" nix` to install the declared Nix
profile, including Fish, then run `fish` to try it. This does not change your
login shell. Add Fish-only machine settings to
`~/.config/fish/config.local.fish`; zsh-specific files such as `~/.local_profile`
are not sourced by Fish. Ghostty detects Fish automatically when it launches
Fish as the shell; starting Fish inside an existing zsh session does not switch
Ghostty's shell integration.

On Windows, `sshtmux user@host` opens an SSH session and starts or attaches to
the remote `main` tmux session. SSH options can be passed as usual, for example
`sshtmux -p 2222 user@host`. Use ordinary `ssh` when you do not want tmux to
start.

## Notes

- `chezmoi apply` is the only way this repo manages dotfiles; do not copy or symlink tracked files manually.
- Machine-specific values and secrets should stay in the untracked `~/.local_profile` or `~/.zshrc.local` files.
