all:
	stow -t ~/ -v X git tmux vim zsh

clean:
	stow -D -t ~/ -v git tmux vim zsh
