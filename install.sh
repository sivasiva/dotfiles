#!/usr/bin/env zsh

echo "Installing dotfiles...";

clear
timestamp=$(date +"%Y%m%d_%H%M%S")
STOW_DIR=$(cd "$(dirname "$0")"; pwd -P)
LOCAL_ZSH=$HOME/.local.zsh
echo "Stow Home=$STOW_DIR"

# optional but recommended
mv ~/.local/share/nvim{,.bak.${timestamp}}
mv ~/.local/state/nvim{,.bak.${timestamp}}
mv ~/.cache/nvim{,.bak.${timestamp}}
mv ~/.config/nvim{,.bak.${timestamp}}
# mv ~/.local.zsh{,.bak.${timestamp}}
echo '1. Backup done.';

cd $STOW_DIR
for file in $STOW_DIR/*; do
  # Only run Stow on the directories in the dotfiles folder and not the individual files.
  # Using 'basename' strips the filepath from the directory name. 

  if [ -d ${file} ]; then
    if [ "$x" != ".DS_Store" ]; then
        stow -t $HOME -R $(basename $file)
        echo "$(basename $file) installed."; 
    fi
  fi
done
echo '2. Install done.';

if [ ! -f $LOCAL_ZSH ]; then
  touch $LOCAL_ZSH
fi

# Return to where we ran the script from
cd ~- 

