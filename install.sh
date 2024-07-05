# This is install script for codespaces
# https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles
sudo apt-get update
sudo apt-get install -y stow make direnv peco tig
make all
