# Dotfiles on my Ubuntu machine
TODO:
  - dotfiles management | what is the best practice?

## using rsync and change the workflow

Write a shell script (e.g., syncdot.sh) to rsync the dotfiles in the git repo,
say, `$HOME/myrepos/dotfiles`, to the `$HOME/` directory.
I decided to put the syncdot.sh file in the same directory as dotfiles, but
it's not necessary.

Change the bash aliases (if any) of openning&editting dotfiles which are the
ones in the git repo

Once udpated the dotfiles, remember to run the `syncdot.sh` to use the new
tricks introduced.

**Downside**:
when you are in vim, working and working, and need to figure out some trick to
solve some tricky problem and add them to .vimrc for next time happy hacking
while not in dotfiles git repo, and you update the .vimrc directly (usually
this .vimrc is the one at `$HOME`). If you forget to manually udpate these
changes to to git repo, when the next time you run the `syncdot.sh`, all the
new tricks may dissappear as if they were never exist 😱

***

## Or you just want to stay in vim ...

Well, let's do it in vim and only in vim.

Combines `:sav!` and an user define vim command

1. set vim command in .vimrc:
```
command Svrc sav! ~/your-git-repo-dir/.vimrc

" then in vim, type :Svrc to save the updated .vimrc to the git repo
```
Note that the `sav!` command will open the .vimrc, the one that was in the repo
you had just saved, in the current buffer, while your working space may not in
that repo, so you need to change to that working directory. And here is the
other command.

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
