PACKAGES := git tmux vim neovim zsh tig ruby peco idea claude direnv mise

all:
	stow -R --no-folding -t ~/ -v $(PACKAGES)

clean:
	stow -D -t ~/ -v $(PACKAGES)
