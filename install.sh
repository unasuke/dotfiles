#!/usr/bin/env bash
# This is install script for codespaces
# https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles
set -euo pipefail

sudo apt-get update
sudo apt-get install -y stow make direnv peco tig

# Codespaces ships its own .zshrc; stow will not overwrite a file it does not own.
rm -f "$HOME/.zshrc"

make all
