#!/usr/bin/env bash

# syncdot: rsync the dotfiles from $HOME to fmhrepos/dotfiles/
#           -f / --force will overwrite the files silently.

PROGNAME=$(basename "$0")

usage () {
    echo "$PROGNAME: usage: $PROGNAME [-f | --force]"
    return
}

# rsync the dotfiles to $HOME
# dooot () {
#     rsync --exclude ".git/" \
#         --exclude "README.md" \
#         --exclude "syncdot.sh" \
#         --exclude ".gitignore" \
#         -avh --no-perms . ~;
#     source ~/.bashrc;
#     echo ""
# }

update_dotfiles () {
    rsync -avh \
        "$HOME"/.gitconfig \
        "$HOME"/.tmux.conf \
        "$HOME"/.vimrc .;
        "$HOME"/.bashrc \
        "$HOME"/.bash_aliases \
        "$HOME"/.bashrc_aliases \
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	update_dotfiles;
else
	read -rp "This may overwrite existing files in current repo. Are you sure? (y/n) " -n 1;
	if [[ $REPLY =~ ^[Yy]$ ]]; then
        update_dotfiles;
	fi;
fi;
unset update_dotfiles;
