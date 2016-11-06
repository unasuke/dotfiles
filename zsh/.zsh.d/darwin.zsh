function peco-select-history() {
  BUFFER=$(history -n 1 | tail -r | peco --query "${LBUFFER}")
  CURSOR=${#BUFFER}
}
zle -N peco-select-history
bindkey '^r' peco-select-history

#ls
alias la='ls -alGh'
alias ll='ls -lGh'

