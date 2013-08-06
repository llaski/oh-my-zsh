ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[cyan]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_DIRTY_SUFFIX="*"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
parse_git() {
  local SUBMODULE_SYNTAX=''
  local GIT_STATUS=''
  local CLEAN_MESSAGE='nothing to commit (working directory clean)'
  if [[ "$(command git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
          SUBMODULE_SYNTAX="--ignore-submodules=dirty"
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
    else
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
    fi
    if [[ -n $GIT_STATUS ]]; then
      echo "$ZSH_THEME_GIT_PROMPT_DIRTY_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_DIRTY_SUFFIX"
    else
      echo "$ZSH_THEME_GIT_PROMPT_CLEAN$(current_branch)"
    fi
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN$(current_branch)"
  fi
}

function get_pwd() {
	echo "${PWD/$HOME/~}"
}

PROMPT='$fg[green]%m $fg[cyan]$(get_pwd) $(git_prompt_info) $fg[white]⚡ '

alias refresh='. ~/.oh-my-zsh/themes/lightning.zsh-theme; . ~/.zshrc;'
alias sites='cd ~/Sites'
