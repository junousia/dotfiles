export ZSH=$HOME/.zsh/oh-my-zsh
source ~/.zsh/git-prompt/zshrc.sh

plugins=(jump git git-extras)

PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin/:$PATH"

alias tags="ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf"
alias gg="git grep"

export LESS=-XRMSI

if [ -e ~/.local_profile ]
then
    source ~/.local_profile
fi

source ${HOME}/.zsh/oh-my-zsh/oh-my-zsh.sh

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"

PROMPT='$fg[green]%m$reset_color:$fg[blue]%~%b$(git_super_status) %# '
