# Keep this shell aligned with the current terminal and the zsh environment.
set -gx COLORTERM truecolor
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
fish_add_path --global --prepend "$HOME/.nix-profile/bin" "$HOME/.opencode/bin" "$HOME/.local/bin"

if command -q direnv
    direnv hook fish | source
end

if command -q fzf
    fzf --fish | source
end

# Keep a host's Fish-only settings outside the managed config.
if test -r "$HOME/.config/fish/config.local.fish"
    source "$HOME/.config/fish/config.local.fish"
end

alias vim='nvim'
alias vi='nvim'
alias g='git'
alias l='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'

if command -q chezmoi
    alias cz='chezmoi'
    alias czs='chezmoi status'
    alias czd='chezmoi diff'
    alias cza='chezmoi apply -v'
    alias cze='chezmoi edit'

    function czcd
        cd (chezmoi source-path)
    end

    function czedit
        chezmoi edit $argv; and chezmoi apply -v
    end
end

function frg --description 'Search files with ripgrep and open a result in Neovim'
    set -l selection (rg --ignore-case --color=always --line-number --no-heading $argv |
        fzf --ansi \
            --color 'hl:-1:underline,hl+:-1:underline:reverse' \
            --delimiter ':' \
            --preview 'bat --color=always {1} --theme="Solarized (light)" --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')

    if test -z "$selection"
        return
    end

    set -l fields (string split -m 2 ':' -- "$selection")
    nvim "+$fields[2]" -- "$fields[1]"
end
