all:
	stow -R --no-folding -t ~/ -v git tmux vim neovim zsh tig ruby peco idea claude direnv mise

clean:
	stow -D -t ~/ -v git tmux vim neovim zsh tig ruby peco idea claude direnv mise
