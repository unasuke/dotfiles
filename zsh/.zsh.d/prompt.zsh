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
