#!/usr/bin/env zsh

clear
timestamp=$(date +"%Y%m%d_%H%M%S")

SRC_DIR=~/projects/dotter
LOCAL_ZSH=$HOME/.local.zsh

# optional but recommended

mv ~/.local/share/nvim{,.bak.${timestamp}}
mv ~/.local/state/nvim{,.bak.${timestamp}}
mv ~/.cache/nvim{,.bak.${timestamp}}
mv ~/.config/nvim{,.bak.${timestamp}}
mv ~/.local.zsh{,.bak.${timestamp}}
echo '1. Config backup completed.';


# echo "Stowing Dotfiles...";

cd $SRC_DIR
for file in $SRC_DIR/*; do
  # Only run Stow on the directories in the dotfiles folder and not the individual files.
  # Using 'basename' strips the filepath from the directory name. 

  if [ -d ${file} ]; then
    if [ "$x" != ".DS_Store" ]; then
        stow -t $HOME -R $(basename $file)
        echo "$(basename $file) stowed."; 
    fi
  fi
done

if [ ! -f $LOCAL_ZSH ]; then
  touch $LOCAL_ZSH
fi

# Return back to the your PWD from before you ran the script
cd ~- 

echo '2. Fresh configs stowed';
