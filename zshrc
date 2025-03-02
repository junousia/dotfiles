export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export TZ="/usr/share/zoneinfo/Europe/Helsinki"

plugins=(common-aliases last-working-dir zsh-navigation-tools helm direnv virtualenv fzf)

autoload znt-history-widget
zle -N znt-history-widget
bindkey "^R" znt-history-widget
znt_list_instant_select=1
znt_list_border=1
znt_list_bold=1
zle -N znt-cd-widget
bindkey "^B" znt-cd-widget
zle -N znt-kill-widget
bindkey "^Y" znt-kill-widget

export FZF_DEFAULT_OPTS="
    --height=40%
    --layout=reverse
    --border
    --info=inline
    --color=dark,bg+:237,bg:236,hl:81,fg:252,fg+:252,hl+:81,info:109,prompt:109,spinner:150
    --prompt='History> '
    --margin=0,5
"


ZSH_CUSTOM=${HOME}/.dotfiles
ZSH_THEME="junou"

export FZF_BASE=~/.vim/bundle/fzf
export ZSH_DISABLE_COMPFIX=true
source ${HOME}/.oh-my-zsh/oh-my-zsh.sh

unsetopt nomatch

export VIRTUAL_ENV_DISABLE_PROMPT=1
alias vim=nvim

function frg {
    result=$(rg --ignore-case --color=always --line-number --no-heading "$@" |
      fzf --ansi \
          --color 'hl:-1:underline,hl+:-1:underline:reverse' \
          --delimiter ':' \
          --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
          --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')
    file=${result%%:*}
    linenumber=$(echo "${result}" | cut -d: -f2)
    if [[ -n "$file" ]]; then
            vim +"${linenumber}" "$file"
    fi
  }

source /app/modules/5/init/zsh.new

_dkr_autocomplete() {
    reply=("am-package-manager" "release-auto" "release-auto-assembly" "argo" "argo-dev")
}
compctl -K _dkr_autocomplete dkr

if [ -e ~/.local_profile ]
then
    source ~/.local_profile
fi
