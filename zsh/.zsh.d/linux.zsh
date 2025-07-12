path=(/usr/local/bin(N-/) $path)

if [[ -f $HOME/.Xresources ]]; then
  xrdb -merge $HOME/.Xresources 1>/dev/null 2>&1
fi

if [[ -f $HOME/.xkb/custom.xkb ]]; then
  xkbcomp ~/.xkb/custom.xkb $DISPLAY1 >/dev/null 2>&1
fi

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


if [[ -f $HOME/share/google-cloud-sdk/completion.zsh.inc ]]; then
  source $HOME/share/google-cloud-sdk/completion.zsh.inc
fi
