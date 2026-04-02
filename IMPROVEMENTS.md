# Improvements

Notes for obvious cleanup and follow-up work in this dotfiles repo.

## Documentation

- Expand the new [README.md](/home/jukka/.local/share/chezmoi/README.md) with explicit prerequisites and platform assumptions for bootstrap.
- Expand [README.md](/home/jukka/.local/share/chezmoi/private_dot_config/nvim/README.md) beyond the default LazyVim starter text so it describes local customizations.

## Bootstrap And Install

- Decide whether [install.sh](/home/jukka/.local/share/chezmoi/install.sh) is still needed or whether setup should be driven primarily through `chezmoi apply`.
- Consider whether the `run_once_*` wrappers should remain in the repo now that [install.sh](/home/jukka/.local/share/chezmoi/install.sh) is the single implementation path.
- Make bootstrap steps safer and more idempotent, especially backup naming in `create_symlink()` and `nvim --headless` plugin sync behavior.
- Add basic runtime verification after bootstrap so failures are surfaced clearly, not just shell syntax.
- Review whether the [Dockerfile](/home/jukka/.local/share/chezmoi/Dockerfile) should test `chezmoi` usage directly instead of invoking the separate installer script.

## Shell And Tooling

- Review whether [dot_zshrc](/home/jukka/.local/share/chezmoi/dot_zshrc) should set `LANG` directly or leave locale configuration to per-machine local state.
- Consider moving machine-specific exports and aliases into a separate local file to keep the tracked config portable.
- Do a second-pass cleanup on [dot_gitconfig](/home/jukka/.local/share/chezmoi/dot_gitconfig) for formatting consistency; a few tabs still remain even after the duplicated settings were removed.

## Repo Hygiene

- Remove or justify the empty [.gitmodules](/home/jukka/.local/share/chezmoi/.gitmodules) file.
- Add a small changelog or decision log if this repo will keep evolving over time.
