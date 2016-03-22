#!/usr/bin/env bash

DEIN_DIR=~/.vim/bundle

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
chmod +x installer.sh
./installer.sh $DEIN_DIR

if [ $? = 0 ]; then
  rm installer.sh
fi
