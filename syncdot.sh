#!/usr/bin/env bash

# syncdot: rsync the dotfiles from git-local-repos/dotfiles/ to $HOME
#           -f / --force will overwrite the files silently.

PROGNAME=$(basename "$0")

usage () {
    echo "$PROGNAME: usage: $PROGNAME [-f | --force]"
    return
}

dooot () {
    rsync --exclude ".git/" \
        --exclude "README.md" \
        --exclude "syncdot.sh" \
        --exclude ".gitignore" \
        -avh --no-perms . ~;
    source ~/.bashrc;
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	dooot;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	if [[ $REPLY =~ ^[Yy]$ ]]; then
        dooot;
    else
        usage;
	fi;
fi;
unset dooot;
