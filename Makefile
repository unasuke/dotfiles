all:
	stow -t ~/ -v git tmux vim zsh tig ruby peco

clean:
	stow -D -t ~/ -v git tmux vim zsh tig ruby peco
