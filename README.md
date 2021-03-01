# Dotfiles on my Ubuntu machine
TODO:
  - dotfiles management | what is the best practice?

## set up git bare repo for dotfiles (step by step guide is [here](https://www.atlassian.com/git/tutorials/dotfiles))

This is trying to set up .git in a subdir say,  /home/user/baregit/, while all
the git-operation can be carried out in dir where dotfiles live (i.e., the ~).
It needs some fine-tune work with `git clone --bare` and some bash aliases.
Good idea that worth trying.

Do not try `git add .`, it will not save your time 🙄

***

## Or you don't want to use the git bare repo technique
Well, let's do it in vim and only in vim.

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
