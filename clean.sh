clear
read -r -p "Are you sure? [y/N] " response
case "$response" in
[yY][eE][sS] | [yY])
	# do_something
	echo "Purging nvim directories."
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim/
	echo "Purge done."
	;;
*)
	# do_something_else
	echo "Purge aborted."
	;;
esac
