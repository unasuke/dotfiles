if [[ -f $HOME/.profile ]]; then
  source $HOME/.profile
fi

if [[ -f $HOME/.Xresources ]]; then
  xrdb -merge $HOME/.Xresources
fi

if [[ -f $HOME/.xkb/custom.xkb ]]; then
  xkbcomp ~/.xkb/custom.xkb $DISPLAY
fi

if [[ $(which kubectl > /dev/null) ]]; then
  source <(kubectl completion zsh)
fi

if [[ $(which helm > /dev/null) ]]; then
  source <(helm completion zsh)
fi

if [[ $(which minikube > /dev/null) ]]; then
  source <(minikube completion zsh)
fi

if [[ $(which stern > /dev/null) ]]; then
  source <(stern --completion=zsh)
fi
