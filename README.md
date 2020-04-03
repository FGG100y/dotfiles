# Dotfiles on my Ubuntu machine
TODO:
  - try dotfiles management tool like dotbot etc
  - update the comments/annotations

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

## Or you don't want to use the git bare repo technique
Well, there's the old saying: where there is will, there is a way. How true. 

### combines :sav! and an other vim command

1. set vim command "Svrc" as "sav! ~/your-git-repo-dir/.vimrc", then use :Svrc
   to save the current edited file to your-git-repo-dir. Note that the "sav!"
   command will open the the saved file in current buffer.

2. set vim command "Curf" as "cd %:p:h \<bar\> :e %", then use :Curf to change
   to your-repo-dir and the most important, open the current edited file again
   so that fugitvie can recognize itself now is in a git repo and make the
   appropriate responds.

When I got some ideas or found some excellent vim tips, I updated my vimrc
immediately. With :Svrc command, I could udpate the .vimrc file to my local git
repository without leaving vim, and then :Curf and then fugitive takes over.
Sweet!
