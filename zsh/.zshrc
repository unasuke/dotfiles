#環境変数を日本語に
export LANG=ja_JP.UTF-8

#vim
export EDITOR=vim

#OS別の設定
case "${OSTYPE}" in
#Mac
darwin*)
	#export path=/usr/local/bin:$PATH
	#homebrew用の補完情報
	path=(~/bin(N-/) /usr/local/bin(N-/) ${path})
	;;
#linux
linux*)
	path=(/usr/local/bin(N-/) $path)
esac

# case "${TERM}" in
# kterm*|xterm)
# 	precmd() {
# 		echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
# 	}
# 	;;
# esac

#補完的な？
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit -u

#補完時に英大文字と小文字を無視する
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#../の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

#sudoのうしろでコマンド名補完
zstyle 'completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
	/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

if [ -f ~/.zsh_profile ]; then
	. ~/.zsh_profile
fi

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

#色を使用できるように
autoload -Uz colors
colors

#日本語ファイル名を表示可能にする
setopt print_eight_bit

#beepを無効に
setopt no_beep

#フローコントロールを無効に(自由なカーソル移動)
setopt no_flow_control

# = の後はPATH名として補完
setopt magic_equal_subst

#同時に起動したzshの間でヒストリの共有
setopt share_history

#同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

#ヒストリに保存する時、すでに重複したコマンドがあったら古い方を削除
setopt hist_save_nodups

#スペースから始まるコマンドはヒストリに残さない
setopt hist_ignore_space

#ヒストリに保存する時余分なスペースを削除
setopt hist_reduce_blanks

#補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

#高機能なワイルドカード展開を使用する
setopt extended_glob

#auto cd
setopt auto_cd
setopt auto_pushd

#誤り訂正
setopt correct

#aliasも展開して補完
setopt complete_aliases

#Ctrl+rで履歴から補完
bindkey -e

###################
##prompt

#current directory path
local p_cdir=$'\n'"%F{blue}[%~]%f"$'\n'

#username and hostname
local p_info="%n@%m"

PROMPT=" $p_cdir$p_info %# "

##rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

function peco-select-history() {
  BUFFER=$(history -n 1 | tail -r | peco --query "${LBUFFER}")
  CURSOR=${#BUFFER}
}
zle -N peco-select-history
bindkey '^r' peco-select-history

source ~/.zsh.d/aliases.zsh

# GO PATH
export GOPATH=$HOME
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# direnv
eval "$(direnv hook zsh)"
