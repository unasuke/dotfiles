#! /bin/bash
cd $(dirname $0)
for dotfile in .?*
do
	if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitmodules' ]
	then
		ln -Fis "$PWD/$dotfile" $HOME
	fi
done

#by neo6120
#thanks!
