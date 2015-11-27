#alias
#ls
alias la='ls -alGh'
alias ll='ls -lGh'

#git
alias g='git'
compdef g=git

#peco
#cd repository
alias e='cd $(ghq list -p | peco)'

#bundler
alias bi='bundle install'
alias be='bundle exec'
