# Dotfiles on my Ubuntu
TODO:
  - try dotfiles management tool like dotbot etc
  - update the comments/annotations
  - change dir to a git repository in vim, but vim did not recognize it. Fixit.

## set up git bare repo for dotfiles: step by step [(original from here)](https://www.atlassian.com/git/tutorials/dotfiles)
1. prior to 'install' the dotfiles, commits the alias to .bashrc first:
 ```shell
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```
2. source repository ignores the folder where will be cloned into, to avoid
   weird recursiion problems:
```shell
echo ".cfg" >> .gitignore
```
3. clone the dotfiles into a **bare** repository in \$HOME/.cfg folder:
```shell
git clone --bare [git-repo-url] $HOME/.cfg
```
4. define the alias in the current shell scope:
```shell
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```
5. if there were dotfiles already in the \$HOME dir, move to backup file first

6. then run the command:
```shell
config checkout
```
7. set the flag 'showUntrackedFiles' to 'no' on this specific repository:
```shell
config config status.showUntrackedFiles no
```
8. create a branch to develop the dotfiles ahead the master version if needed:
```shell
config checkout -b repo-branch-name
config push -u origin repo-branch-name
```
9. Done. From now on, type config commands to add and update dotfiles:
```shell
config status
config add .vimrc
config commit -m 'add vimrc'
...
config push
```
NOTE that the alias 'config' may seem confusing sometime, change it at will.

I myself used 'dcfg', i.e., dotfiles config.

***

## set local existing branch tracked upstream/branch

1. create the branch, said 'py202'
```sh
git branch py202
```
2. set py202 tracking upstream/branch, said origin/wh608
```sh
git branch -u origin/wh608 py202
```
3. Done.

***

## vim :sav! to update the dotfiles in the local branch

When I got some ideas or found some excellent vim tips, I updated my vimrc
immediately. With :sav command, I could udpate the vimrc in my dotfiles of
local git repository without leaving vim, and when all changes done, :CDC to
change dir to the current file's path (i.e., my local git repo), then fugitive
would handle the rest.
Sweet!
