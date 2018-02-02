function peco-select-history() {
  BUFFER=$(history -n 1 | tac | peco --query "${LBUFFER}")
  CURSOR=${#BUFFER}
}
zle -N peco-select-history
bindkey '^r' peco-select-history

alias ll='ls --color=auto -lh'
alias la='ls --color=auto -alh'

if [[ -f $HOME/.Xresources ]]; then
  xrdb -merge $HOME/.Xresources
fi
