#
# 这里大部分是可以直接照搬的，但挑选适合自己的即可（你不会知道别人的一些习惯会多离谱）
# 这里大部分是可以直接照搬的，但挑选适合自己的即可（你不会知道别人的一些习惯会多离谱）
# 这里大部分是可以直接照搬的，但挑选适合自己的即可（你不会知道别人的一些习惯会多离谱）
#
# Ubuntu 22.04-LTS ^^
# last modified: 2024-09-20 Fri

# ----------------
# Personal Aliases
# ----------------

##启动之前要关掉VPN，否则无法弹出登录地址
# sudo tailscale up
## 关闭
# sudo tailscale down

# 注释下面这一句，执行`source .bash_aliases`则会打印出所有命令别名(包括其他地方定义的)
# alias

# must update several env vars before you can compile and run OpenVINO applications
alias vino24='source /opt/intel/openvino_2024/setupvars.sh'
alias vino25='source /opt/intel/openvino_2025/setupvars.sh'

alias gj='shutdown now'

# step back to parent dir
alias ..='cd ..'
alias ...='cd ../..'

# source ***
alias srcsh='source ~/.bash_aliases'
# wget continue download flags
alias wget='wget -c'
# tree the directory
alias tree2='tree -dL 2'
alias tree3='tree -dL 3'
alias treepy='tree -I "__pycache__|*.egg-info"'
alias tree3py='tree -dL 3 -I "__pycache__|*.egg-info|tmp"'
# In case of careless rm
alias rm='rm -i'
alias mv='mv -i'
alias cpr='cp -r'
# Prevents accidentally clobbering files
alias mkdir='mkdir -p'
alias which='type -a'
# Makes a more readable output
alias df='df -kTh'
alias du='du -mh'
alias dirsize='du -sh --apparent-size'
alias du9='du -Sh | sort -rh | head -9'
alias du1='du --max-depth=1 | sort -h'
alias sudodu1='sudo du -mh --max-depth=1 | sort -h'

# rsync show progress info
alias rsync='rsync -av --info=progress2'

# var/log/journal clean up:
alias vlog100m="sudo journalctl --vacuum-size=100M"
alias vlog14d="sudo journalctl --vacuum-time=14d"

# ps and grep with header
alias fmhps='ps -ef | egrep "PID|${USER}"'

alias lsfonts='fc-list  | cut -d\  -f2-99 | cut -d: -f1 | sort -u'
alias lsfontszh='fc-list :lang=zh-cn | cut -d\  -f2-99 | cut -d: -f1 | sort -u'

# xfce monitor setting extend to left
alias monitorpd2left="xrandr --output HDMI-A-0 --auto --left-of eDP"
alias monitorpd2right="xrandr --output HDMI-A-0 --auto --right-of eDP"

#testPyPI: fmh99; PyPI: fan99; password see API-token in $HOME/.pypirc
alias testpypi='twine upload --repository testpypi --skip-existing dist/*'

# 踏雪无痕
alias txwh='ssh -t dstsvr sudo -S lastlog --clear --user fmh'

# kde theme dark/light toggle/switch:
alias toggletheme="/home/fmh/sourceCode/switchThemeDarkLight/theme_switcher.sh"

# HF model download:
alias hfdl="HF_ENDPOINT=https://hf-mirror.com python download_llm_huggingface.py --repo_id "
alias msdl="python download_llm_modelscope.py --repo_id "


# cursorAppImage
alias cursorApp="/home/fmh/Downloads/Tools/cursor-0.41.1-build-2409189xe3envg5-x86_64.AppImage &"

# --------------
# edit dotfiles
# --------------
alias vi='/usr/local/bin/vim'
alias ve='view'
alias vimsh='vim $HOME/.bashrc'
alias vimbz='vim $HOME/.bash_aliases'
alias vimbl='vim $HOME/.bash_aliases_local'
alias vimrc='vim $HOME/.vimrc'
alias vimtx='vim $HOME/.tmux.conf'
alias vimgc='vim $HOME/.gitconfig'

# -------------
# tmux commands
# -------------
alias txls='tmux ls'
alias txat='tmux attach -t'
alias txks='tmux kill-session -t'
# alias txns='tmux new-session -s'
# alias txsh='tmux new-session -s shell'

# ------------------
# The 'ls' family :)
# barely changed
# use exa instead(?) 2023-03-13 23:02:10 星期一
# ------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color --group-directories-first'
# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias l="ls -lF --group-directories-first"
alias ll="ls -lhv --group-directories-first"
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias llr='ll -R'          #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias hidden='ls -d .*'    # show dot files only
alias hf="ls -d .* | grep '^\.'"    # exclude directories
alias hd="ls -d .* | grep -v '^\.'" # keep directories only

# 如果终端不能访问此地址，可能需要检查防火墙端口设置 (ufw allow 8000/tcp)
# 且已经设置: sudo ufw default deny incoming
alias httpy='python3 -m http.server -b $(hostname -I | cut -d" " -f 1)'
# using en_US.utf8 in R;
# maybe better than change the locale or so
alias R='LANGUAGE=en_US.UTF-8 R --no-save'
# python shortcuts
alias py='python3'
alias ipy='ipython3'
alias pipqh='pip install -i https://pypi.tuna.tsinghua.edu.cn/simple'
# convert ipynb notebook to restructured format
alias nb2rst='jupyter nbconvert --to rst'
# cookiecutter alias
alias mkccds='cookiecutter -c v1 https://github.com/drivendata/cookiecutter-data-science'
# Julia-lang
alias julia='$HOME/Julia/julia-1.6.7/bin/julia'

# ---------------
# handy functions
# ---------------
# github mirror
function gitmirror() { git clone https://mirror.ghproxy.com/$1 ; }

# test microphone working or not:
function test-microphone() {
    arecord -vvv -f dat /dev/null
}

# die-hard terminal nostalgists:
function readme75cols() { fmt -s -w 75 < $1 | less ; }

# Creates an archive (*.tar) from given directory
function mktar() { tar cvf "${1%%/}.tar" "${1%%/}"; }
# Creates an archive (*.tar.gz) from given directory
function mktgz() { tar cvzf "${1%%/}.tar.gz" "${1%%/}"; }

# Creates a ZIP archive of file or folder
function mkzip() { zip -r "${1%%/}.zip" "$1" ; }

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

# --------------
# language group
# --------------
# complier for C++
# -----------------
# alias gpp='g++ -std=c++14 -Wall -Wextra -Werror'
alias mygpp11='g++ -std=c++11 -Wall -Wextra -Werror'
# alias clang='clang -std=c++11 -stdlib=libc++ -lc++ -lm -Werror -Weverything'
# alias clang='clang -std=c++11 -stdlib=libc++ -lc++ -lm -Werror -Weverything -Wno-c++98-compat-pedantic'

# NOTE: more paras/flags for clang:
# clang -Wno-disabled-macro-expansion -Wno-float-equal -Wno-c++98-compat-pedantic'
#       -Wno-global-constructors -Wno-missing-prototypes -Wno-padded
#       -Wno-old-style-cast

# --------------
# fmh preference
# --------------

# unzip 中文乱码
# apt install unar && unar 鬼佬不懂中文.zip

# set vi mode in bash
set -o vi

# terminal cursor green; when it does not work, config the console GUI instead
echo -ne "\e]12;green\a"

# for vim colorschmes
# alternative: alias vim='vim -T xterm-256color'
export TERM=xterm-256color

# trim path in prompt
export PROMPT_DIRTRIM=0

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir" || exit
}

# bash-git-prompt; if the synbols cutter, change the terminal fonts
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    unset PROMPT_COMMAND
    GIT_PROMPT_ONLY_IN_REPO=0
    # GIT_PROMPT_THEME=Single_line_Ubuntu
    GIT_PROMPT_THEME=Solarized_Ubuntu
    # BASH_GIT_PROMPT__MAX_WIDTH=100
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# cht.sh bash-completion
if [ -f "$HOME/.bash.d/cht.sh" ]; then
    . ~/.bash.d/cht.sh
fi

# pyenv
PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# NOTE 首次安装可能会报错，主要是系统依赖未安装，例如：
# sudo apt-get install build-essential zlib1g-dev libbz2-dev libreadline-dev
#   \ libsqlite3-dev libssl-dev libncurses5-dev libncursesw5-dev tk-dev tcl-dev
#   \ libffi-dev liblzma-dev
# NOTE $1 must be x.y.z format; x.y not ok
pyenv_install(){
    local version=${1:-"3.11.9"}
        # Regular expression to match x.y.z where x, y, and z are integers
    if [[ $version =~ ^[2-4]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Valid version format."
    else
        echo "Invalid version format. Please enter the version as x.y.z."
        return 1
    fi
    echo "Proceeding with downloading Python $version..."
    # wget "https://mirrors.sohu.com/python/$version/Python-$version.tar.xz" -P ~/.pyenv/cache/
    wget "https://mirrors.huaweicloud.com/python/$version/Python-$version.tar.xz" -P ~/.pyenv/cache/
    pyenv install $version
}


# # outdated aliases:
# alias vpngddst='sudo openvpn /etc/openvpn/gddst.x3322.net.ovpn'
# alias wechat='LANG=zh_CN.UTF-8 wine /home/ds01/.wine/drive_c/Program\ Files\ \(x86\)/Tencent/WeChat/WeChat.exe'
# alias stopwinetricks='winetricks --optout'
# # server side UDP port temporary config: sudo iptables -I INPUT 1 -p udp --dport 60000:60010 -j ACCEPT
# alias mosh181='mosh -p 60001 --predict=always --experimental-remote-ip=remote --ssh="/usr/bin/ssh -p 40181 -i ~/.ssh/id_rsa" fmh@gddst.wicp.vip'
# alias mosh183='mosh -p 60001 --ssh="/usr/bin/ssh -p 40183 -i ~/.ssh/id_ed25519" fmh@gddst.wicp.vip'
# # alias mosh183='mosh -p 60001 --predict=always --experimental-remote-ip=remote --ssh="/usr/bin/ssh -p 40183 -i ~/.ssh/id_ed25519" fmh@gddst.wicp.vip'
#
# # 为什么非要连接服务器上的？无它，服务器性能强劲 (但要接受网络差的现实)
# alias jlab181='echo "connect to http://localhost:8181 (jupyterlab on svr181)" && ssh -NL localhost:8181:localhost:8181 fmhshell_181'
# alias hzzjlab='echo "connect to http://localhost:8900 (jupyterlab on svr183)" && ssh -NL localhost:8900:localhost:8900 fmhshell_183'
# alias jlab183='echo "connect to http://localhost:8183 (jupyterlab on svr183)" && ssh -NL localhost:8183:localhost:8183 fmhshell_183'
# alias tsb183='echo "connect to http://localhost:6006 (tensorboard on svr183)" && ssh -NL localhost:6006:localhost:6006 fmhshell_183'
# alias fcllm='echo "connect to http://localhost:7860 (gradio on svr183)" && ssh -NL localhost:7860:localhost:7860 fmhshell_183'
# alias bcllm='echo "connect to http://localhost:8501 (streamlit on svr183)" && ssh -NL localhost:8501:localhost:8501 fmhshell_183'
# # alias llmcpp='echo "connect to http://localhost:8080 (llama.cpp on svr183)" && ssh -NL localhost:8080:localhost:8080 fmhshell_183'
# alias llmcpp='echo "connect to http://localhost:8081 (llama.cpp on svr183)" && ssh -NL localhost:8081:localhost:8081 fmhshell_183'
# # 本地 venv, jupyterlab 环境(必须到相应的根目录再执行命令):
# # 指定pdb环境: PYTHONBREAKPOINT='IPython.core.debugger.set_trace' envpy run.py
# alias envpy='./.venv/bin/python3'
# alias envpip='./.venv/bin/pip3'
# alias envjpl='./.venv/bin/jupyter-lab'
# # base venv
# alias venvDS='source ~/venv/bin/activate'

# ANDROID_HOME for bazel
export ANDROID_HOME=$HOME/Android/Sdk/
