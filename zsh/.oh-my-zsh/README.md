# my-zsh #

这篇记录了自己zsh的配置，一点一点地完善和补充。

## 配置主题 ##

在`~/.zshrc`配置主题,如果为空，则不使用任何主题。

```
ZSH_THEME="befunny"
```

主题配置文件在`~/.oh-my-zsh/themes`目录下，添加自定义的主题配置文件`befunny.zsh-theme`:

```
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

PROMPT='%{$fg_bold[green]%}(%D %T)%{$reset_color%} %{$fg[yellow]%}%n@%m%{$reset_color%}%{$fg_bold[red]%}➜%{$fg_bold[green]%}%p%{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}
%{$fg_bold[green]%}->%{$reset_color%} '

function echo_blank(){
    echo
}
preexec_functions+=echo_blank
precmd_functions+=echo_blank

```

### 常用的命令前导符 ###

`zsh`定义了代表各种信息的[前导占位符](https://www-s.acm.illinois.edu/workshops/zsh/prompt/escapes.html)，常见的如下：

```
General
%n The username
%m The computer's hostname(truncated to the first period)
%M The computer's hostname
%l The current tty
%? The return code of the last-run application.
%# The prompt based on user privileges
Times
%T System time(HH:MM)
%* System time(HH:MM:SS)
%D System date(YY-MM-DD)
Directories
%~ The current working directory.
If you are in you are in your $HOME, this will be replaced by ~.
%d The current working directory.
```

如果想让光标换行，则在设置`PROMPT`时直接换行即可，如下所示：

```
PROMPT='%n@%m
'
```

为了使输出结构清晰，这里分别在输出结果之前和之后添加一行空行：

```
function echo_blank(){
    echo
}
preexec_functions+=echo_blank
precmd_functions+=echo_blank
```

### 配置颜色 ###

这里的颜色配置不是指终端的颜色，而是命令前导符、命令的颜色。

颜色可以用`fg`(加粗可以使用`fg_bold`)来调用，如设置用户名和主机名为黄色：

```
PROMPT='%{$fg_bold[yellow]%}%n@%m%{$reset_color%}'
```

一旦设置某颜色，则后续都会变成这种颜色，如果只需要一部分为此颜色，则在该部分之后需要重设颜色，`reset_color`就是起这个作用。

