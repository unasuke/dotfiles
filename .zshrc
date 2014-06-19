#環境変数を日本語に
export LANG=ja_JP.UTF-8

#OS別の設定
case "${OSTYPE}" in
#Mac
darwin*)
	#export path='/usr/local/bin:$PATH'
	#MacVimのPATHを設定
	export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
	alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

	#homebrew用の補完情報
	path=(~/bin(N-/) /usr/local/bin(N-/) ${path})
	;;
#linux
linux*)
	;;
esac

case "${TERM}" in
kterm*|xterm)
	precmd() {
		echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	}
	;;
esac

#補完的な？
autoload -U compinit
compinit

if [ -f ~/.zsh_profile ]; then
	. ~/.zsh_profile
fi

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
