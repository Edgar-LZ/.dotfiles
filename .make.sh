#!/bin/bash
######################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles
#######################

### Variables

dir=~/.dotfiles					# dotfiles directory
olddir=~/dotfiles_old			# old dotiles backup directory
files="basrc vimrc gitconfig"	# list of files/folders

############

# create dotfiles_old in homedir
echo "Creating $olddir for backup of existing dotfiles in ~"
mkdir -p $olddir
echo "... done"

# Move existing dotfiles to dotfiles_old and create symlinks
for files in $files; do
	mv ~/.$file $olddir/$file
	echo "Creating symlink to $file in home directory."
	ln -s $dir/.$file ~/.$file
done

