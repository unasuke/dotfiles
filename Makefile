all:
	stow -t ~/ -v git tmux vim zsh tig ruby peco idea

linux:
	stow -t ~/ -v X

clean:
	stow -D -t ~/ -v git tmux vim zsh tig ruby peco idea
