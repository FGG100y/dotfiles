# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias usage='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias ls="ls --color"

## Powerline
#if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
    #source /usr/share/powerline/bindings/bash/powerline.sh
#fi

function greeting() {
    # Linux Lite Custom Terminal
    LLVER=$(awk '{print}' /etc/llver)
    echo -e "Welcome to $LLVER, ${USER}"
    echo " "
    #date "+%A %d %B %Y, %T"
    date "+%A %F, %T"
    df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
    free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
    echo "Support - https://www.linuxliteos.com/forums/"
    echo " "
}
greeting

if [ -f ~/.bashrc_aliases ]; then
    source ~/.bashrc_aliases
fi

if [ -f ~/.bashrc_aliases_local_only ]; then
    source ~/.bashrc_aliases_local_only
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ds01/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ds01/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ds01/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ds01/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# # asdf:
# . "$HOME/.asdf/asdf.sh"
# . "$HOME/.asdf/completions/asdf.bash"

# pyenv:
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# nvim
NVIM_PATH="$HOME/nvim-linux64/bin"
export PATH=$NVIM_PATH:$PATH
