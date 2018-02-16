#alias
#git
alias g='git'
compdef g=git

#peco
#cd repository
alias e='cd $(ghq list -p | peco)'

#bundler
alias bi='bundle install'
alias be='bundle exec'

#vim
alias vi='vim'

#docker
alias dc='docker-compose'

#kubernetes
alias ku='kubectl'

#clipboard(linux) (clipboard copy/paste)
alias clc='xsel -bi'
alias clp='xsel -bo'
