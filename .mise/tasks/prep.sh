echo "DISABLED"
exit 1

SRC=~/dotter/lazy/.config/nvim
TARGET=~/.config/nvim

echo "Source: $SRC"
echo "Target: $TARGET"

cp $SRC/lua/config/options.lua $TARGET/lua/config/
cp $SRC/lua/config/keymaps.lua $TARGET/lua/config/

cp $SRC/lua/plugins/alpha.lua $TARGET/lua/plugins/
cp $SRC/lua/plugins/disabled.lua $TARGET/lua/plugins/
cp $SRC/lua/plugins/projects.lua $TARGET/lua/plugins/
cp $SRC/lua/plugins/snippets.lua $TARGET/lua/plugins/
cp $SRC/lua/plugins/tmux.lua $TARGET/lua/plugins/
cp $SRC/lua/plugins/tree.lua $TARGET/lua/plugins/
cp $SRC/lua/plugins/ui.lua $TARGET/lua/plugins/

