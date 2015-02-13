export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="simple"

plugins=(zsh_reload vim-interaction tmux jump git git-extras colorize)

PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin/:$PATH"

alias tags="ctags -R --c++-kinds=+p --fields=+iaS --extra=+q"
export LESS=-XRMSI

if [ -e ~/.local_profile ]
then
    source ~/.local_profile
fi

source ${HOME}/.oh-my-zsh/oh-my-zsh.sh
