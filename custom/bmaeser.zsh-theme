# my zsh prompt

# dont need promptinit, have my own
#autoload -U promptinit && promptinit

setopt prompt_subst #turn on command substitution in the prompt

## indicate if last command exited with 0 or failed
local prmt_exit_status="%(?,%{$fg[green]%}✓%{$reset_color%},%{$fg[red]%}✗%{$reset_color%})"


## tell me if this a ssh-session
if [[ -z "$SSH_CLIENT" ]]; then
    prmpt_ssh=""
else
    prmpt_ssh="%{$fg[red]%}(ssh) %{$reset_color%}"
fi

## if username == root the indicate warning color
if [ $UID -eq 0 ]; then
    prmpt_user="%{$fg[red]%}%n%{$reset_color%}"
else
    prmpt_user="%{$fg[cyan]%}%n%{$reset_color%}"
fi

## virtualenvwrapper

# disable default prompt prefix by virtualenvwrapper
export VIRTUAL_ENV_DISABLE_PROMPT=1

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="env:%{$fg[yellow]%}"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$reset_color%}"

function virtualenv_prompt_info() {
    if [ -n "$VIRTUAL_ENV" ]; then
        if [ -f "$VIRTUAL_ENV/__name__" ]; then
            local name=`cat $VIRTUAL_ENV/__name__`
        elif [ `basename $VIRTUAL_ENV` = "__" ]; then
            local name=$(basename $(dirname $VIRTUAL_ENV))
        else
            local name=$(basename $VIRTUAL_ENV)
        fi
        echo "$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX$name$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
    fi
}

## git

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX="git:%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} •%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} •%{$fg[yellow]%}"


PROMPT='
${prmt_exit_status} ${prmpt_ssh}${prmpt_user} at %{$fg[cyan]%}%m%{$reset_color%} in %{$fg[green]%}%~%{$reset_color%}
> %{$reset_color%}'

RPROMPT='$(virtualenv_prompt_info) $(git_prompt_info)%{$RESET_COLOR%}'


