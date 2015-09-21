all:
	stow -t ~/ -v git tmux vim zsh tig

clean:
	stow -D -t ~/ -v git tmux vim zsh tig
