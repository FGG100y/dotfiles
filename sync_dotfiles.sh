#!/usr/bin/env bash

# update_dotfiles: rsync the dotfiles from $HOME to current repo.
#           -f / --force will overwrite the files silently.

PROGNAME=$(basename "$0")

usage () {
    echo "rsync the dotfiles from $HOME to current repo. Option -f will silently overwrite files"
    echo "usage: $PROGNAME [-f | --force]"
    echo
    return
}

update_dotfiles () {
    rsync -avh \
        "$HOME"/.gitconfig \
        "$HOME"/.tmux.conf \
        "$HOME"/.bash_aliases \
        "$HOME"/.vimrc .;
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    usage;
elif [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	update_dotfiles;
else
	read -rp "To overwrite [gitconfig,tmux.conf,bash_aliaes,vimrc] in current repo. Are you sure? (y/n) " -n 1;
	if [[ $REPLY =~ ^[Yy]$ ]]; then
        update_dotfiles;
	fi;
fi;

unset update_dotfiles;
