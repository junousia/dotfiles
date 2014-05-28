source ${HOME}/.dotfiles/zsh/zsh-git-prompt/zshrc.sh
PROMPT='%B%m%~%b$(git_super_status) %# '

setopt NOTIFY
setopt APPEND_HISTORY
setopt CORRECT      # command CORRECTION
setopt EXTENDED_HISTORY   # puts timestamps in the history
setopt HIST_ALLOW_CLOBBER
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt ALL_EXPORT

setopt MENUCOMPLETE
setopt notify globdots correct pushdtohome cdablevars autolist
setopt correctall autocd recexact longlistjobs
setopt autoresume histignoredups pushdsilent noclobber
setopt autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin/:$PATH"

HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000

setopt share_history

alias tags="ctags -R --c++-kinds=+p --fields=+iaS --extra=+q"
source ~/.local_profile
