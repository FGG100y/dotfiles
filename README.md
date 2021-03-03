# Dotfiles on my Linux machine

TODO:
  - dotfiles management | what is the best practice?

## using rsync and change the workflow

1. rsync the dotfiles to `$HOME` (especially after a git pull or merge)
Write a shell script (e.g., syncdot.sh) to rsync the dotfiles from a git local
repo, say, `$HOME/myrepos/dotfiles`, to the `$HOME/` directory then the script
do the `source .bashrc` to make it work.

I put the syncdot.sh in the same directory as dotfiles, but it's not necessary.

2. change the workflow (`#HOME/.dotfile` saved to git-repos)
Generally, when we edit/update the .vimrc file, we want it to work immediately
to get the benefit or bug. So the keyboard short-cut would usually bind to edit
the `$HOME/.vimrc`, we update it, make it work and keep on solving problems.

It's not always that the changes are came from git pull or merge, so it's
better to change the workflow to adapt more flexible and effective procedure.

**Potential Downside**:
Yet the one in the git-repo was still outdated, if you forget to manually
udpate these changes to git local repo, when the next time you run the
`syncdot.sh`, all the new tricks may dissappear as if they were never exist 😱

So we need a handy command to save the changes to the local repo. The `sav!`.

***

## vim command to quickly save the .vimrc to git-repo

All we need to do can be include into two steps:

1. set first command in .vimrc:
```
command Svrc sav! ~/your-git-repo-dir/.vimrc

" then in vim, type :Svrc to save the updated .vimrc to the git repo
```
Note that the `sav!` command will open the .vimrc, the one that was in the repo
we had just saved, in the current buffer, while our working space may not in
that repo (we are still at the directory where we init the vim), so we need to
move to that working directory if we want to use fugitive to take over the rest
works which make this less man power involed. And here is the other command.

2. set second command in .vimrc:
```
command CC cd %:p:h | :e %

" CC means Change to directory of Current buffer's file
" then use :CC to do the trick
```
The most important was, `| :e` part in the the command would open the current
edited file again so that [fugitvie](https://github.com/tpope/vim-fugitive),
an great tool, could recognize itself that it is in a git repo and ready to
take over the charge. Then the fugitive is 'at your service'. Sweet!

## save dotfiles changes to git-repo with specific bash-aliases

When it comes to the other dotfiles but .vimrc, such .bashrc/.gitconf etc, it
is more sketical to adapt new settings especially when some lines copied from
the network you don't fully understand. It may be a good idea to udpate it in
the git-repo dotfiles, manually check these lines, then sync them to `$HOME`.

1. dotfiles editing aliases: (in .bashrc_aliases or the sort)
```sh
export DOTPATH=$HOME/your-path-to/dotfiles
alias vimsh='vim $DOTPATH/.bashrc'
alias vimbz='vim $DOTPATH/.bashrc_aliases'
alias vimrc='vim $DOTPATH/.gitconf'
alias vimtx='vim $DOTPATH/.tmux.conf'
```

2. remember to run the `syncdot.sh` to make them alive.

***

## set up git bare repo for dotfiles (step by step guide is [here](https://www.atlassian.com/git/tutorials/dotfiles))

This is trying to set up .git in a subdir say,  /home/user/baregit/, while all
the git-operation can be carried out in dir where dotfiles live (i.e., the ~).
It needs some fine-tune work with `git clone --bare` and some bash aliases.
Good idea that worth trying.

The downside (in my case) is that I don't know how to adapt the bare-git-repo
with the bash-git-prompt tool which is also a really good tool.

Do not try `git add .`, it will not save your time 🙄
