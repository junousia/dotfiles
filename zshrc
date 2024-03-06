export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export TZ="/usr/share/zoneinfo/Europe/Helsinki"

plugins=(common-aliases last-working-dir zsh-navigation-tools fasd helm wd direnv virtualenv ripgrep kubectl kubectx kube-ps1 fzf)

autoload znt-history-widget
zle -N znt-history-widget
bindkey "^R" znt-history-widget
znt_list_instant_select=1
znt_list_border=0
znt_list_bold=0

ZSH_THEME="junou" # set by `omz`

if [ -e ~/.local_profile ]
then
    source ~/.local_profile
fi

export FZF_BASE=~/.fzf
source ${HOME}/.oh-my-zsh/oh-my-zsh.sh

unsetopt nomatch

export VIRTUAL_ENV_DISABLE_PROMPT=1
alias vim=nvim
