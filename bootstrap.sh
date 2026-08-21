#!/usr/bin/env bash
# One-shot environment restore on a new machine.
# Usage: bootstrap.sh [--dry-run] [--skip apt,pipx,apps,stow,vimpack,post] [--only ...]
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(bash vim nvim tmux git claude opencode gh vscode cursor ideavim fcitx5 misc)
DRY=0
SKIP=""
ONLY=""

usage() {
    cat <<EOF
Restore working environment on a new machine.
Phases: apt pipx apps stow vimpack post

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

phase_post() {
    cat <<EOF

===== 手动收尾 =====
[1] gh auth login
[2] 密钥: 写进 ~/.bashrc.local（export ANTHROPIC_AUTH_TOKEN=... 等），模板见 README；
    Claude Code 若不经 shell 启动，另建 ~/.claude/settings.local.json（README 有模板）
[3] tmux: apt 版 3.2a 缺 extended-keys/OSC52 支持，按 README 附录自编译 3.7b 放 ~/.local/bin
[4] fzf: git clone https://github.com/junegunn/fzf ~/.fzf && ~/.fzf/install
[5] tmux 插件: tmux 内 prefix-I（tpm 自动装）
[6] nvim: 首次启动 lazy.nvim 按 lazy-lock.json 自动装
[7] YCM: cd ~/.vim/pack/vendor/start/YouCompleteMe && python3 install.py
EOF
}

main() {
    parse_args "$@"
    for ph in apt pipx apps stow vimpack post; do
        skip_phase "$ph" || "phase_$ph"
    done
}

main "$@"
