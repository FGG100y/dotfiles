# Dotfiles on my Ubuntu machine

## using rsync to udpate dotfile repo as needed

When it comes to dotfiles, one would like to make a change and get the effects
ASAP. Make some aliases to quickly open and record new tricks, source it and
enjoy it. And regularly update the repo's then push it to remote repo so that
it can be shared to all other machines.

## Or you just want to update repo/vimrc immediately

Well, let's do it in vim and only in vim.

Combines `:sav!` and an user define vim command

1. set vim command in .vimrc:
```
command Svrc sav! ~/your-git-repo-dir/.vimrc

" then in vim, type :Svrc to save the updated .vimrc to the repo dir
```
Note that the `sav!` command will open the repo/.vimrc which you just saved,
in the current buffer, while your working space (pwd would tell) may not in
that repo, so you need to change the working directory to repo dir so that
fugitive can recognize. And here is the other command.

2. set vim command in .vimrc:
```
" CC means Change to directory of Current file

command CC cd %:p:h | :e %

" then use :CC to do the trick
```
The most important was, `| :e` part in the the command would open the current
edited file again so that [fugitvie](https://github.com/tpope/vim-fugitive) an
other great tool, could recognize itself that it is in a git repo already and
make the appropriate responds. Then the fugitive took over. Sweet!

3. the other dotfiles need to config the specific command (in step 1)

***

## set up git bare repo for dotfiles (step by step guide is [here](https://www.atlassian.com/git/tutorials/dotfiles))

This is trying to set up .git in a subdir say,  /home/user/baregit/, while all
the git-operation can be carried out in dir where dotfiles live (i.e., the ~).
It needs some fine-tune work with `git clone --bare` and some bash aliases.
Good idea that worth trying.

The downside (in my case) is that I don't know how to adapt the bare-git-repo
with the bash-git-prompt tool which is a really good tool.

Do not try `git add .`, it will not save your time 🙄

***
