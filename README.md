# Dotfiles on my Ubuntu machine

## using rsync to udpate repo/dotfiles as needed

When it comes to dotfiles, one would like to make a change and get the effects
ASAP. Edit the dotfiles, save and source them (if needed). That's how to make
them work. If you work on more than one machine, you will want to sync the
dotfiles. And propably you don't want to do it one file a time. So, a bash
srcipt way help. I myself use this `syncdot.sh` (in the same dir) to sync all
my dotfiles to my git repository, then make some good commits and push it to
remote repository. Now it's easy to be shared to all other machines.

Or you just want to update repo/vimrc immediately ...

## vim command to quickly save the .vimrc to git-repo

All we need to do can be include into two steps:

1. set first command in .vimrc:
```
command Svrc sav! ~/your-git-repo-dir/.vimrc

" then in vim, type :Svrc to save the updated .vimrc to the repo dir
```
Note that the `sav!` command will open the repo/.vimrc which you just saved,
in the current buffer, while your working space (pwd would tell) may not in
that repo, so you need to change the working directory to repo dir so that
fugitive can recognize. And here is the other command.

2. set second command in .vimrc:
```
command CC cd %:p:h | :e %

" CC means Change to directory of Current buffer's file
" then use :CC to do the trick
```
The most important was, `| :e` part in the the command would open the current
edited file again so that [fugitvie](https://github.com/tpope/vim-fugitive) an
other great tool, could recognize itself that it is in a git repo already and
make the appropriate responds. Then the fugitive took over. Sweet!

3. the other dotfiles need to config the specific command (in step 1)

***

## set up git bare repo for dotfiles
(step by step guide is [here](https://www.atlassian.com/git/tutorials/dotfiles))

This is trying to set up .git in a subdir say,  /home/user/baregit/, while all
the git-operation can be carried out in dir where dotfiles live (i.e., the ~).
It needs some fine-tune work with `git clone --bare` and some bash aliases.
Good idea that worth trying.

The downside (in my opinion) is that:
1) I don't know how to adapt the bare-git-repo with the
[bash-git-prompt](https://github.com/magicmonty/bash-git-prompt).
2) It's not so good that build a repo in `$HOME` dir and lots of files to be
ignored. And then,
3) The temptation become stronger, but, DO NOT try `git add .`, it will not
save your time 🙄

***
