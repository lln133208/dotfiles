local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

# git information
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

#cli prompt
PROMPT='%{$fg_bold[green]%}(%D %T)%{$reset_color%} %{$fg[yellow]%}%n@%m%{$reset_color%}%{$fg_bold[red]%} ➜ %{$fg_bold[green]%}%p%{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}
%{$fg_bold[green]%}->%{$reset_color%} '

#get a blank line after each output
function echo_blank(){
    echo
}
preexec_functions+=echo_blank
precmd_functions+=echo_blank
