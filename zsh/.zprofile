if [[ -f $HOME/.Xresources ]]; then
  xrdb -merge $HOME/.Xresources
fi

if [[ -f $HOME/.xkb/custom.xkb ]]; then
  xkbcomp ~/.xkb/custom.xkb $DISPLAY
fi

# Ubuntu make installation of Ubuntu Make binary symlink
PATH=/home/unasuke/.local/share/umake/bin:$PATH

if [[ $(which kubectl) ]]; then
  source <(kubectl completion zsh)
fi

if [[ $(which helm) ]]; then
  source <(helm completion zsh)
fi

if [[ $(which minikube) ]]; then
  source <(minikube completion zsh)
fi

if [[ $(which stern) ]]; then
  source <(stern --completion=zsh)
fi
