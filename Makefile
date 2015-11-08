all:
	stow -t ~/ -v git tmux vim zsh tig ruby

clean:
	stow -D -t ~/ -v git tmux vim zsh tig ruby
