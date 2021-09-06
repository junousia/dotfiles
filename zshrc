export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export TZ="/usr/share/zoneinfo/Europe/Helsinki"

plugins=(common-aliases last-working-dir zsh-navigation-tools fasd helm wd)

autoload znt-history-widget
zle -N znt-history-widget
bindkey "^R" znt-history-widget
znt_list_instant_select=1
znt_list_border=0
znt_list_bold=0

ZSH_THEME="alanpeabody"

if [ -e ~/.local_profile ]
then
    source ~/.local_profile
fi

source ${HOME}/.oh-my-zsh/oh-my-zsh.sh
path+=("${HOME}/local/bin")
export PATH

unsetopt nomatch
