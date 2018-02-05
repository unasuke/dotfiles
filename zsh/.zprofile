if [[ -f $HOME/.Xresources ]]; then
  xrdb -merge $HOME/.Xresources
fi

if [[ -f $HOME/.xkb/custom.xkb ]]; then
  xkbcomp ~/.xkb/custom.xkb $DISPLAY
fi

# Ubuntu make installation of Ubuntu Make binary symlink
PATH=/home/unasuke/.local/share/umake/bin:$PATH
