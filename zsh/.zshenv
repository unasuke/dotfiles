typeset -gU PATH

export LANG=ja_JP.UTF-8
export EDITOR=vim
export PATH=$HOME/.rbenv/bin:$PATH
# export PATH=$HOME/.cargo/bin:$PATH
# export PATH=$HOME/.nodenv/bin:$PATH
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$HOME/.tfenv/bin:$PATH
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH
export BUNDLE_JOBS=4

if [[ -f /etc/lsb-release && $(grep Ubuntu /etc/lsb-release) ]]; then
  export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
fi

if [[ $(which yarn > /dev/null 2>&1) ]]; then
  export PATH=$(yarn global bin):$PATH
fi

