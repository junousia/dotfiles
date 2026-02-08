# Functions

# Interactive ripgrep + fzf
function frg {
    result=$(rg --ignore-case --color=always --line-number --no-heading "$@" |
      fzf --ansi 
          --color 'hl:-1:underline,hl+:-1:underline:reverse' 
          --delimiter ':' 
          --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" 
          --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')
    file=${result%%:*}
    linenumber=$(echo "${result}" | cut -d: -f2)
    if [[ -n "$file" ]]; then
            vim +"${linenumber}" "$file"
    fi
}
