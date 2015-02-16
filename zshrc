export ZSH=$HOME/.oh-my-zsh
source ~/.dotfiles/zsh/git-prompt/zshrc.sh

plugins=(zsh_reload vim-interaction tmux jump gitfast)

PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin/:$PATH"

alias tags="ctags -R --c++-kinds=+p --fields=+iaS --extra=+q"
export LESS=-XRMSI

if [ -e ~/.local_profile ]
then
    source ~/.local_profile
fi

source ${HOME}/.oh-my-zsh/oh-my-zsh.sh

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"

PROMPT='$fg[green]%m$reset_color:$fg[blue]%~%b$(git_super_status) %# '
