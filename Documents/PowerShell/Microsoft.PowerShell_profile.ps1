# Share the same Neovim config location as Linux and macOS.
if (-not $env:XDG_CONFIG_HOME) {
    $env:XDG_CONFIG_HOME = Join-Path $HOME ".config"
}

function cz { chezmoi @args }
function czs { chezmoi status @args }
function czd { chezmoi diff @args }
function cza { chezmoi apply --verbose @args }
function cze { chezmoi edit @args }
function czcd { Set-Location (chezmoi source-path) }
function czedit { chezmoi edit --apply @args }

if (Get-Command nvim -ErrorAction SilentlyContinue) {
    Set-Alias vim nvim
}

$localProfile = Join-Path $PSScriptRoot "Microsoft.PowerShell_profile.local.ps1"
if (Test-Path $localProfile) {
    . $localProfile
}
