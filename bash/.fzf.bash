# Setup fzf
# ---------
if [[ ! "$PATH" == */$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

command -v fzf >/dev/null && eval "$(fzf --bash)"
