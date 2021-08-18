#!/usr/bin/env bash

# syncdot: rsync the dotfiles from $HOME to fmhrepos/dotfiles/
#           -f / --force will overwrite the files silently.

PROGNAME=$(basename "$0")

usage () {
    echo "$PROGNAME: usage: $PROGNAME [-f | --force]"
    return
}

# dooot () {
#     rsync --exclude ".git/" \
#         --exclude "README.md" \
#         --exclude "syncdot.sh" \
#         --exclude ".gitignore" \
#         -avh --no-perms . ~;
#     source ~/.bashrc;
#     echo ""
# }

udpate_dotfiles () {
    rsync -avh "$HOME"/.bashrc "$HOME"/.bashrc_aliases \
        "$HOME"/.gitconfig "$HOME"/.tmux.conf "$HOME"/.vimrc .;
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	udpate_dotfiles;
else
	read -p "This may overwrite existing files in current repo. Are you sure? (y/n) " -n 1;
	if [[ $REPLY =~ ^[Yy]$ ]]; then
        udpate_dotfiles;
	fi;
fi;
unset udpate_dotfiles;
