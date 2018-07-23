export ZSH=$HOME/.zsh/oh-my-zsh

plugins=(last-working-dir)

ZSH_THEME="alanpeabody"
PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin/:$PATH"

if [ -e ~/.local_profile ]
then
    source ~/.local_profile
fi

source ${HOME}/.zsh/oh-my-zsh/oh-my-zsh.sh

unsetopt nomatch
