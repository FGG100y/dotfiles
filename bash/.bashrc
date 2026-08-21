# OPENSPEC:START
# OpenSpec shell completions configuration
if [ -d "$HOME/.local/share/bash-completion/completions" ]; then
  for f in "$HOME/.local/share/bash-completion/completions"/*; do
    [ -f "$f" ] && . "$f"
  done
fi
# OPENSPEC:END

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases_local ]; then
    . ~/.bash_aliases_local
fi

# per-machine aliases: ~/.bash_aliases_<hostname> (not tracked in repo)
if [ -f "$HOME/.bash_aliases_$(hostname)" ]; then
    . "$HOME/.bash_aliases_$(hostname)"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Created by `pipx` on 2024-07-27 01:20:08
export PATH="$PATH:$HOME/.local/bin"
command -v pipx >/dev/null && eval "$(register-python-argcomplete pipx)"
[ -x "$HOME/.pyenv/versions/3.11.9/bin/python" ] && export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.11.9/bin/python"

# node18
export PATH="$PATH:$HOME/node18.18.1/bin"


# locale: en_US for easier debugging
LANG=en_US.utf8
LANGUAGE=
LC_ALL=en_US.utf-8
# LC_TIME=en_US.utf8  # THIS will not display 24-hour time
LC_TIME=C.utf8
export LANG
export LANGUAGE
export LC_TIME

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# Wrapper to run OpenCode with oh-my-opencode only when requested.
# Default behavior:
# - `opencode` => vanilla OpenCode (no oh-my-opencode)
# - `omo`      => OpenCode + oh-my-opencode (runtime-only override)
#
# Requirement:
# - `~/.config/opencode/opencode.json` should NOT already contain oh-my-opencode.

omo() {
  local config_file="$HOME/.config/opencode/opencode.json"
  local updated_json

  updated_json=$(jq '
    .plugin = (
      (.plugin // [])
      | if any(.[]; test("^oh-my-opencode(@.*)?$")) then
          .
        else
          . + ["oh-my-opencode@latest"]
        end
    )
  ' "$config_file")

  OPENCODE_CONFIG_CONTENT="$updated_json" opencode "$@"
}
command -v uv >/dev/null && eval "$(uv generate-shell-completion bash)"

## claude code & LLM providers (secrets live in ~/.bashrc.local)
## DeepSeek
export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
#export ANTHROPIC_MODEL=deepseek-v4-pro[1m]
#export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro[1m]
#export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro[1m]
export ANTHROPIC_MODEL=deepseek-v4-pro[1m]
export ANTHROPIC_DEFAULT_OPUS_MODEL=deepseek-v4-pro[1m]
#export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-pro[1m]
export ANTHROPIC_DEFAULT_SONNET_MODEL=deepseek-v4-flash
export ANTHROPIC_DEFAULT_HAIKU_MODEL=deepseek-v4-flash
export CLAUDE_CODE_SUBAGENT_MODEL=deepseek-v4-flash
export CLAUDE_CODE_EFFORT_LEVEL=max
export CLAUDE_CODE_AUTO_COMPACT_WINDOW=786432

# Pi
export PATH="$HOME/.local/share/pi-node/node-v22.23.2-linux-x64/bin:$PATH"

# Java: 命令行 launcher 统一到 JBR 21（与 Gradle daemon toolchain 保持一致）
[ -d "$HOME/.jdks/jbr-21.0.11" ] && export JAVA_HOME="$HOME/.jdks/jbr-21.0.11"

# machine-local secrets, never commit
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
