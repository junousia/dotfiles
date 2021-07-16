export ZSH=$HOME/.zsh/oh-my-zsh

plugins=(common-aliases last-working-dir zsh-navigation-tools fasd)

autoload znt-history-widget
zle -N znt-history-widget
bindkey "^R" znt-history-widget
znt_list_instant_select=1
znt_list_border=0
znt_list_bold=1

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

eval "$(direnv hook zsh)"

fix_ssh () {
    eval $(tmux show-env -s |grep '^SSH_')
}
fix_ssh
