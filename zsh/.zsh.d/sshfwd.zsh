sshfwd() {
  local usage_server="usage (inside SSH session): sshfwd <remote_port> [<local_port>]"
  local usage_client="usage: sshfwd <host> <remote_port> [<local_port>]"

  if [[ $# -lt 1 ]]; then
    if [[ -n "${SSH_CONNECTION}" ]]; then
      print -u2 -- "${usage_server}"
    else
      print -u2 -- "${usage_client}"
    fi
    return 1
  fi

  if [[ "$1" == <-> ]]; then
    if [[ -z "${SSH_CONNECTION}" ]]; then
      print -u2 -- "sshfwd: server-side mode requires an active SSH session"
      print -u2 -- "${usage_client}"
      return 1
    fi

    local remote_port="$1"
    local local_port="${2:-$remote_port}"
    local host="${SSHFWD_HOST:-$(hostname)}"
    local cmd="sshfwd ${host} ${remote_port} ${local_port}"

    # OSC 52 copies to the SSH client's clipboard; tmux set-clipboard/allow-passthrough forwards it.
    printf '\033]52;c;%s\033\\' "$(printf '%s' "${cmd}" | base64 | tr -d '\n')"

    print -- "Copied to clipboard. Run on your client:"
    print -- "  ${cmd}"
    return 0
  fi

  if [[ $# -lt 2 ]]; then
    print -u2 -- "${usage_client}"
    return 1
  fi

  local host="$1"
  local remote_port="$2"
  local local_port="${3:-$remote_port}"
  local spec="${local_port}:localhost:${remote_port}"

  # Prefer attaching to an existing ControlMaster; fall back to a backgrounded tunnel so the caller returns immediately either way.
  if ssh -O forward -L "${spec}" "${host}" 2>/dev/null; then
    print -- "forwarded ${host}:${remote_port} -> localhost:${local_port}"
    return 0
  fi

  print -- "no active ControlMaster for ${host}; starting background tunnel..."
  ssh -f -N -L "${spec}" "${host}"
}
