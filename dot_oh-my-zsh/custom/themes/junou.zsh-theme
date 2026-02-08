local user='%{$fg[magenta]%}%n%{$reset_color%}'
local pwd='%{$fg[blue]%}%~%{$reset_color%}'

PROMPT="${user}:${pwd} » "
RPROMPT='%(?..%{$fg[red]%}%?%{$reset_color%})'
