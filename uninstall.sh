#!/usr/bin/env zsh

echo "Un-stowing Dotfiles...";

SRC_DIR=~/projects/dotter

cd $SRC_DIR
for file in $SRC_DIR/*; do
  # Only run Stow on the directories in the dotfiles folder and not the individual files.
  # Using 'basename' strips the filepath from the directory name. 

  if [ -d ${file} ]; then
    if [ "$x" != ".DS_Store" ]; then
        stow -D -t $HOME -R $(basename $file)
        echo "$(basename $file) un-stowed."; 
    fi
  fi
done

# Return back to the your PWD from before you ran the script
cd ~- 

echo 'All un-stowed';
