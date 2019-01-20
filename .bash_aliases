#------------------
# Personnal Aliases
#------------------

# some commands about wudao-dict
alias wds='wd -s'
# personnal directory
alias Juno='cd /home/fgg/JupyterNotebook/'
alias Leco='cd /home/fgg/JupyterNotebook/GitHub_repo/LeetCode/'
alias Djgo='cd /home/fgg/JupyterNotebook/virtualenvs/fggdjango/'
alias Webs='cd /home/fgg/JupyterNotebook/virtualenvs/fggdjango/fggsite'
# conda activate virtual envs
alias Sact='source activate'
alias Dact='source deactivate'

# python -m activate envs
alias Sadj='source ~/JupyterNotebook/virtualenvs/django/bin/activate'
# wget
alias wget='wget -c'

# In case of careless rm
alias rm='rm -i'
alias mv='mv -i'

# Prevents accidentally clobbering files
alias mkdir='mkdir -p'

alias h='history'
alias which='type -a'
alias ..='cd ..'

# Pretty-print of some PATH variables
alias path='ehco -e ${PATH//:/\\n}'
alias libpath='ehco -e ${LD_LIBRARY_PATH//:/\\n}'

# Makes a more readable output
alias du='du -kh'
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
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
#alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

# Creates an archive (*.tar.gz) from given directory
function maketar() { tar cvzf "${1%%/}.tar.gz" "${1%%/}"; }

# Creates a ZIP archive of file or folder
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

