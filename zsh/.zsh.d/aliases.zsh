####################
##alias

alias la='ls -alGh'
alias ll='ls -lGh'

alias g='git'
compdef g=git

##peco

#cd repository
alias e='cd $(ghq list -p | peco)'

