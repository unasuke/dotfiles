# emacs bind(before to peco)
bindkey -e

#OS別の設定
case "${OSTYPE}" in
#Mac
darwin*)
  # export GPG_AGENT_INFO  # the env file does not contain the export statement
  # export SSH_AUTH_SOCK   # enable gpg-agent for ssh
  # export GPG_TTY=`tty`
  # pgrep -q gpg-agent || eval $(gpg-agent --quiet --daemon --enable-ssh-support)

  #git pretty diff
  export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
  source ~/.zsh.d/darwin.zsh
	;;
#linux
linux*)
	path=(/usr/local/bin(N-/) $path)
  source ~/.zsh.d/linux.zsh
  if [[ -f $HOME/.Xresources ]]; then
    xrdb -merge $HOME/.Xresources 1>/dev/null 2>&1
  fi

  if [[ -f $HOME/.xkb/custom.xkb ]]; then
    xkbcomp ~/.xkb/custom.xkb $DISPLAY1 >/dev/null 2>&1
  fi
	;;
# windows (msys2)
msys*)
  source ~/.zsh.d/msys.zsh
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
fpath=(/usr/local/share/zsh $fpath)
fpath=(~/.rbenv/completions $fpath)

autoload bashcompinit && bashcompinit
autoload -Uz compinit compinit

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
#setopt auto_cd
setopt auto_pushd

#誤り訂正
setopt correct

#aliasも展開して補完
setopt complete_aliases

###################
##prompt

# for vcs
# see also http://qiita.com/mollifier/items/8d5a627d773758dd8078
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:git:*' formats '(%b)' '%c%u %m'
zstyle ':vcs_info:git:*' actionformats '(%b)' '%c%u %m' '<!%a>'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"

local -a vcs_prompt
function _update_vcs_info_msg() {
    local -a messages

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        vcs_prompt=""
    else
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )
        vcs_prompt="${(j: :)messages}"
    fi
}
add-zsh-hook precmd _update_vcs_info_msg

local -a gcloud_prompt
function _update_gcloud_project() {
  if command -v gcloud 1>/dev/null 2>&1; then
    gcloud_prompt=`grep 'project' ~/.config/gcloud/configurations/config_default | awk '{print $3}'`
  fi
  #if [[ -f '.gcloud' ]]; then
  #  gcloud_prompt=`grep 'project' ~/.config/gcloud/configurations/config_default | awk '{print $3}'`
  #else
  #  gcloud_prompt=""
  #fi
}
add-zsh-hook precmd _update_gcloud_project

function _update_prompt() {
  #current directory path
  local p_cdir="%F{blue}[%~]%f""$vcs_prompt""%F{white}$gcloud_prompt%f"$'\n'

  #username and hostname
  local p_info=$'\n'"[%n@%m]"

  # PROMPT=" $p_cdir$p_info %# "
  PROMPT=" $p_info$p_cdir%# "
}
add-zsh-hook precmd _update_prompt

if [[ -f ~/.local/bin/mise ]]; then
  eval "$(~/.local/bin/mise activate zsh)"
fi

source ~/.zsh.d/aliases.zsh

# direnv
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if command -v kubectl 1>/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init - --no-rehash zsh)"
fi

if [[ -f ~/.extrarc ]]; then
  source ~/.extrarc
fi

eval "$(/home/unasuke/.local/bin/mise activate zsh)"

if [[ -f $HOME/.profile ]]; then
  source $HOME/.profile
fi

if [[ -f $HOME/.Xresources ]]; then
  xrdb -merge $HOME/.Xresources
fi

if [[ -f $HOME/.xkb/custom.xkb ]]; then
  xkbcomp ~/.xkb/custom.xkb $DISPLAY
fi

if [[ $(which kubectl > /dev/null) ]]; then
  source <(kubectl completion zsh)
fi

if [[ $(which helm > /dev/null) ]]; then
  source <(helm completion zsh)
fi

if [[ $(which minikube > /dev/null) ]]; then
  source <(minikube completion zsh)
fi

if [[ $(which stern > /dev/null) ]]; then
  source <(stern --completion=zsh)
fi

# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
if which aws_completer > /dev/null; then
  complete -C "$(which aws_completer)" aws
fi
