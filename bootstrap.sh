#!/usr/bin/env bash
# One-shot environment restore on a new machine.
# Usage: bootstrap.sh [--dry-run] [--skip apt,pipx,apps,extras,stow,vimpack,post] [--only ...]
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(bash vim nvim tmux git claude opencode gh vscode cursor ideavim fcitx5 misc)
DRY=0
SKIP=""
ONLY=""

usage() {
    cat <<EOF
Restore working environment on a new machine.
Phases: apt pipx apps extras stow vimpack post

Options:
  -n, --dry-run    print commands without running them
      --skip LIST  comma-separated phases to skip
      --only LIST  run only these phases (comma-separated)
  -h, --help       this help
EOF
}

parse_args() {
    while [ $# -gt 0 ]; do
        case "$1" in
            -n|--dry-run) DRY=1 ;;
            --skip) SKIP="${2//,/ }"; shift ;;
            --only) ONLY="${2//,/ }"; shift ;;
            -h|--help) usage; exit 0 ;;
            *) echo "unknown arg: $1" >&2; usage >&2; exit 1 ;;
        esac
        shift
    done
}

# skip_phase <name>  -> 0 when the phase should be skipped
skip_phase() {
    case " $SKIP " in *" $1 "*) return 0 ;; esac
    if [ -n "$ONLY" ]; then
        case " $ONLY " in *" $1 "*) : ;; *) return 0 ;; esac
    fi
    return 1
}

run() { if [ "$DRY" = 1 ]; then echo "[dry] $*"; else "$@"; fi; }
have() { command -v "$1" >/dev/null 2>&1; }
warn() { echo "$*" >&2; }

phase_apt() {
    have apt-get || { warn "apt 不可用，跳过 apt 阶段"; return; }
    run sudo apt-get update
    run sudo apt-get install -y $(grep -vE '^\s*(#|$)' "$DOTFILES_DIR/packages/apt.list")
}

phase_pipx() {
    have pipx || run sudo apt-get install -y pipx
    while read -r pkg; do
        have "$pkg" || run pipx install "$pkg"
    done < <(grep -vE '^\s*(#|$)' "$DOTFILES_DIR/packages/pipx.list")
}

phase_apps() {
    have claude || run bash -c 'curl -fsSL https://claude.ai/install.sh | bash'
    have opencode || run bash -c 'curl -fsSL https://opencode.ai/install | bash'
}

phase_extras() {
    # optional tools referenced by the configs; install only when missing
    [ -d "$HOME/.fzf" ] || run bash -c 'git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all'
    [ -x "$HOME/.local/bin/uv" ] || run bash -c 'curl -LsSf https://astral.sh/uv/install.sh | sh'
    [ -x "$HOME/.pyenv/bin/pyenv" ] || run bash -c 'curl https://pyenv.run | bash'
    [ -s "$HOME/.nvm/nvm.sh" ] || run bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
}

phase_stow() {
    have stow || run sudo apt-get install -y stow
    cd "$DOTFILES_DIR"
    for p in "${PACKAGES[@]}"; do
        run stow -t "$HOME" "$p" || \
            warn "!! stow 冲突: $p（home 已有真实文件；确认内容一致后可用 stow --adopt，见 README）"
    done
}

phase_vimpack() {
    run bash "$DOTFILES_DIR/vim-packsync.sh"
}

tmux_bin() {
    if [ -x "$HOME/.local/bin/tmux" ]; then
        echo "$HOME/.local/bin/tmux"
    elif have tmux; then
        command -v tmux
    fi
}

phase_post() {
    # 装 pre-commit 密钥扫描钩子（symlink 到仓库内版本，随 git pull 更新）
    if [ -f "$DOTFILES_DIR/hooks/pre-commit" ]; then
        # 新机器 clone 时 init.templateDir 可能已放进一份副本，统一换成 symlink
        [ -L "$DOTFILES_DIR/.git/hooks/pre-commit" ] || run ln -sf ../../hooks/pre-commit "$DOTFILES_DIR/.git/hooks/pre-commit"
    fi
    # 全局 git 模板：新 init/clone 的仓库自动带上同一钩子
    if [ -f "$DOTFILES_DIR/hooks/pre-commit" ]; then
        run mkdir -p "$HOME/.git-template/hooks"
        run cp "$DOTFILES_DIR/hooks/pre-commit" "$HOME/.git-template/hooks/pre-commit"
        run git config --global init.templateDir "~/.git-template"
    fi
    # detection-driven: only list what THIS machine actually lacks
    cat <<EOF

===== 手动收尾（只列当前机器缺的）=====
EOF
    if have gh && gh auth status >/dev/null 2>&1; then
        echo "  gh: OK"
    else
        echo "  [gh] gh auth login"
    fi
    [ -f "$HOME/.bashrc.local" ] || echo "  [密钥] 建 ~/.bashrc.local（export ANTHROPIC_AUTH_TOKEN=...，模板见 README）"
    [ -f "$HOME/.claude/settings.local.json" ] || echo "  [claude] 不经 shell 启动 claude 时，建 ~/.claude/settings.local.json（模板见 README）"
    tb="$(tmux_bin)"
    if [ -z "$tb" ]; then
        echo "  [tmux] 未安装；apt 阶段应已装，若没有请检查"
    else
        ver="$("$tb" -V 2>/dev/null | awk '{print $2}' | sed 's/[^0-9.]//g')"
        if [ -n "$ver" ] && [ "$(printf '%s\n3.6' "$ver" | sort -V | head -1)" != "3.6" ]; then
            echo "  [tmux] 版本 $ver < 3.6，extended-keys/OSC52 会报错；按 README 附录自编译 3.7b 到 ~/.local/bin"
        else
            echo "  tmux: OK ($ver)"
        fi
    fi
    [ -d "$HOME/.tmux/plugins/tpm" ] || echo "  [tmux] 插件: tmux 内 prefix-I（tpm 自动装）"
    [ -d "$HOME/.local/share/nvim/lazy" ] || echo "  [nvim] 首次启动 lazy.nvim 按 lazy-lock.json 自动装"
    if [ -d "$HOME/.vim/pack/vendor/start/YouCompleteMe" ] && [ ! -d "$HOME/.vim/pack/vendor/start/YouCompleteMe/third_party/ycmd" ]; then
        echo "  [YCM] cd ~/.vim/pack/vendor/start/YouCompleteMe && python3 install.py"
    fi
}

main() {
    parse_args "$@"
    for ph in apt pipx apps extras stow vimpack post; do
        skip_phase "$ph" || "phase_$ph"
    done
}

main "$@"
