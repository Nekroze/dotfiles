HISTCONTROL=ignoreboth
shopt -s histappend
export HISTFILESIZE=
export HISTSIZE=
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
