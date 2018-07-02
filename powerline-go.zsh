#!/usr/bin/env zsh
function powerline_precmd() {
    PS1="$(powerline-go -error $? -shell zsh -cwd-max-dir-size 10 -modules 'time,cwd,newline,git,perms,nix-shell,jobs,exit,root')"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ] && [ -x "$(command -v powerline-go)" ]; then
    install_powerline_precmd
fi
