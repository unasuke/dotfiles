export LANG=ja_JP.UTF-8
export EDITOR=vim
export PATH=$HOME/.rbenv/bin:$PATH
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/.nodenv/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$HOME/.tfenv/bin:$PATH

if [[ -f /etc/lsb-release && $(grep Ubuntu /etc/lsb-release) ]]; then
  export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
fi
