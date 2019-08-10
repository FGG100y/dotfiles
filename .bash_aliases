#------------------
# Personnal Aliases
#------------------
# personnal directory
alias Juno='cd /home/fgg/JupyterNotebook/'
alias ss='cd /home/fgg/JupyterNotebook/Practical_ss/'
alias pypy='cd /home/fgg/JupyterNotebook/Practical_Py3/'
alias ccpp='cd /home/fgg/JupyterNotebook/Practical_Cpp/'
alias cv='cd /home/fgg/JupyterNotebook/Practical_DS/CV/'
alias Gitr='cd /home/fgg/JupyterNotebook/GitHub_repo/'
alias Leco='cd /home/fgg/JupyterNotebook/GitHub_repo/LeetCode/'
# alias Djgo='cd /home/fgg/JupyterNotebook/virtualenvs/fggdjango/'
# alias Webs='cd /home/fgg/JupyterNotebook/virtualenvs/fggdjango/fggsite'

# vim edit multiple files vertically split windows
alias vimvs='vim -O'
# compiling new vim with py3 supported, but the /usr/bin/vim still work
alias vim='/usr/share/bin/vim'

# shell scripts commands
alias chmodx='chmod u+x'

# complier for C++
alias gpp='g++ -std=c++11 -Wall -Wextra -Werror'
# alias clang='clang -std=c++11 -stdlib=libc++ -lc++ -lm -Werror -Weverything'
alias clang='clang -std=c++11 -stdlib=libc++ -lc++ -lm -Werror -Weverything -Wno-c++98-compat-pedantic'

# NOTE: more paras/flags for clang:
# clang -Wno-disabled-macro-expansion -Wno-float-equal -Wno-c++98-compat-pedantic'
#       -Wno-global-constructors -Wno-missing-prototypes -Wno-padded
#       -Wno-old-style-cast 

# source ***
alias srcsh='source ~/.bashrc'
# poweroff
alias pof='poweroff'
# tree the directory
alias tree2='tree -aL 2'
alias tree3='tree -dL 3'
# alias treed='tree -aL 2 -D'

# edit dotfiles
alias vimbz='vim ~/.bash_aliases'
alias vimrc='vim ~/.vimrc'
alias vimtx='vim ~/.tmux.conf'

# git command lines
alias gits='git status'
alias gitbr='git branch'
alias gitad='git add'
alias gitcm='git commit -m'
alias gitpom='git push origin master'
# git rm to rename file's name
# git mv means exactly:
#   mv file_from file_to
#   git rm file_from
#   git add file_to
alias gitmv='git mv'
# rm staged file from repos but still stay in local file system
alias gitrmc='git rm --cached'
# check history commits
alias gitlg='git log'
alias gitlgp='git log --pretty=format:"%h -%an, %ar : %s"'
alias gitlgg='git log --pretty=format:"%h %s" --graph'
alias gitlgm='git log --since=4.weeks'
# quick search, git log -Sfunction_name: commits with function_name
alias gitlgs='git log -S'

alias tmux='tmux -2'
# tmux commands
alias tmuxls='tmux ls'
# alias tmuxac='tmux attach'
alias tmuxat='tmux attach'
alias tmuxns='tmux new-session -s'
alias tmuxsh='tmux new-session -s shell'
alias tmuxks='tmux kill-session -t'

# some commands about wudao-dict
alias wds='wd -s'

# python -m activate envs
alias Qenv='deactivate'
alias Stf='source ~/JupyterNotebook/VirtualEnvsPy3/tf_py36/bin/activate'
alias Scv='source ~/JupyterNotebook/VirtualEnvsPy3/cv_py36/bin/activate'
alias Sdj='source ~/JupyterNotebook/VirtualEnvsPy3/django/bin/activate'

# wget
alias wget='wget -c'

# In case of careless rm
alias rm='rm -i'
alias mv='mv -i'
alias cpr='cp -r'

# Prevents accidentally clobbering files
alias mkdir='mkdir -p'

alias his='history'
alias which='type -a'
alias ..='cd ..'

# Pretty-print of some PATH variables
alias path='ehco -e ${PATH//:/\\n}'
alias libpath='ehco -e ${LD_LIBRARY_PATH//:/\\n}'

# Makes a more readable output
alias du='du -mh'
alias df='df -kTh'

#-------------------
# The 'ls' family :)
#-------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias llm='ll |more'        #  Pipe through 'more'
alias llr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
#alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

# Creates an archive (*.tar.gz) from given directory
function maketar() { tar cvzf "${1%%/}.tar.gz" "${1%%/}"; }

# Creates a ZIP archive of file or folder
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

function extract()      # Handy Extract Program
{
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf "$1"     ;;
            *.tar.xz)    tar xvJf "$1"     ;;
            *.tar.gz)    tar xvzf "$1"     ;;
            *.bz2)       bunzip2 "$1"      ;;
            *.rar)       unrar x "$1"      ;;
            *.gz)        gunzip "$1"       ;;
            *.tar)       tar xvf "$1"      ;;
            *.tbz2)      tar xvjf "$1"     ;;
            *.tgz)       tar xvzf "$1"     ;;
            *.zip)       unzip "$1"        ;;
            *.Z)         uncompress "$1"   ;;
            *.7z)        7z x "$1"         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# function to show git branch in shell directory
# get current git branch
# parse_git_branch() {
#     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }
# export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
