# Dotfiles on my Ubuntu
TODO:
  - try dotfiles management tool like dotbot etc
  - update the comments/annotations

## set up git bare repo for dotfiles: step by step [original from here](https://www.atlassian.com/git/tutorials/dotfiles)
1. prior to 'install' the dotfiles, commits the alias to .bashrc first:
 ```shell
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' >> $HOME/.bashrc"
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
