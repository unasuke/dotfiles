#! /bin/bash
cd $(dirname $0)
for dotfile in .?*
do
	if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitmodules' ] && [ $dotfile != '.gitignore' ]
	then
		ln -Fis "$PWD/$dotfile" $HOME
	fi
done

#by neo6120
#thanks!
