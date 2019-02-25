export ZSH=$HOME/.zsh/oh-my-zsh

plugins=(common-aliases last-working-dir zsh-navigation-tools)

autoload znt-history-widget
zle -N znt-history-widget
bindkey "^R" znt-history-widget

ZSH_THEME="alanpeabody"
PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin/:$PATH"

if [ -e ~/.local_profile ]
then
    source ~/.local_profile
fi

source ${HOME}/.zsh/oh-my-zsh/oh-my-zsh.sh
path+=("${HOME}/local/bin")
export PATH

unsetopt nomatch
