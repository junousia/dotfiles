function fish_prompt
    set -l user "$USER"
    if test -z "$user"
        set user (whoami)
    end

    set_color magenta
    printf '%s' "$user"
    set_color normal
    printf ':'
    set_color blue
    printf '%s' (prompt_pwd)
    set_color normal
    printf ' » '
end
