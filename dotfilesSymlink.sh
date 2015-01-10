#! /bin/bash
cd $(dirname $0)
for dotfile in .?*
do
	if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitmodules' ] && [ $dotfile != '.gitignore' ]
	then
		ln -Fis "$PWD/$dotfile" $HOME
	fi
done

echo "If it's first run, get neobundle.vim using git."
echo "mkdir -p ~/.vim/bundle"
echo "git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim"

#by neo6120
#thanks!
