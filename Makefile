all:
	stow -t ~/ -v git tmux vim neovim zsh tig ruby peco idea claude ssh

linux:
	stow -t ~/ -v X

clean:
	stow -D -t ~/ -v git tmux vim neovim zsh tig ruby peco idea claude ssh
