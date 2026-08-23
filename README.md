# My Dotfiles

GNU stow 管理的个人 dotfiles。目标：在新机器上快速恢复工作环境（工具 + 配置）。

## 新机器恢复

```bash
# 1. 基础工具
sudo apt install git stow

# 2. 克隆仓库
git clone git@github.com:FGG100y/dotfiles.git ~/dotfiles

# 3. 一键 bootstrap：apt + pipx + claude/opencode + 可选工具(uv/pyenv/nvm/fzf) + stow 部署
cd ~/dotfiles && ./bootstrap.sh
#    可用 --dry-run 预览、--skip apt,pipx,... 跳阶段；结尾只列当前机器真缺的手动项

# 4. vim pack 插件
./vim-packsync.sh        # 之后更新用 ./vim-packsync.sh --update

# 5. 手动收尾（bootstrap 结尾也会提醒）：
#    - gh auth login
#    - 密钥写入 ~/.bashrc.local（见下）
#    - tmux 内 prefix-I 装 tpm 插件；nvim 首次启动自动装 lazy 插件
```

## 日常更新

```bash
# home 里的点文件就是指向本仓库的符号链接，直接编辑后提交即可
vim ~/.vimrc && cd ~/dotfiles && git commit -am '...'

# 新增一个配置：放入对应包目录，再部署
mkdir -p ~/dotfiles/foo && cp ~/.config/foo.conf ~/dotfiles/foo/
cd ~/dotfiles && stow -t ~ foo && git add foo && git commit -m 'Add foo'
```

## 密钥放哪（绝不入库）

| 密钥 | 位置 |
|---|---|
| shell 环境变量（ANTHROPIC_AUTH_TOKEN、DEEPSEEK_API_KEY…） | `~/.bashrc.local`（.bashrc 末尾自动 source） |
| 项目级 Claude Code env（换供应商/模型时） | 项目 `.claude/settings.local.json`（`~/.config/git/ignore` 已全局忽略，不进 git） |

```bash
# ~/.bashrc.local
export ANTHROPIC_AUTH_TOKEN=sk-xxx
export DEEPSEEK_API_KEY=sk-xxx
```

```json
// <项目>/.claude/settings.local.json —— 只在该项目生效
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk-xxx",
    "ANTHROPIC_BASE_URL": "https://api.deepseek.com/anthropic",
    "API_TIMEOUT_MS": "3000000"
  }
}
```

> 注意：用户级 `~/.claude/settings.local.json` **不存在**——Claude Code 不读这个文件。只有从 `$HOME` 启动时它才会被当作「home 目录这个项目」的项目级 local 文件偶然生效，其他目录下静默无效（`/status` → Setting sources 可验证）。

## Claude Code 模型/供应商配置（备忘：方案待定，尚未迁移）

现状：`.bashrc` 的 `## DeepSeek` 块 export 端点 + 模型槽位（入库）；token 在 `~/.bashrc.local`。待决定是否迁移、多供应商怎么组织。

官方结论（2026-08 查 code.claude.com/docs）：

- 供应商是**进程级**配置：一个会话只有一个 `ANTHROPIC_BASE_URL`；settings.json 不能写多个 env 块，也不存在「按模型路由端点」。
- settings 文件的 env **覆盖** shell 同名变量（改完需重启）。因此入库的 `~/.claude/settings.json` 不能放 env——否则 shell / 项目 local 层全部失效。
- 模型是槽位映射：`ANTHROPIC_MODEL` + `ANTHROPIC_DEFAULT_{OPUS,SONNET,HAIKU,FABLE}_MODEL` + `CLAUDE_CODE_SUBAGENT_MODEL`（官方变量，管子代理），`/model` 切换；`ANTHROPIC_SMALL_FAST_MODEL` 已废弃（= HAIKU）。
- 自定义 base_url 下模型 ID 不做校验，端点接受什么就写什么。
- 更多模型入口：`CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY=1`（端点实现 `GET /v1/models` 时，所有模型自动进 `/model` 列表）；`ANTHROPIC_CUSTOM_MODEL_OPTION`（手动加一条自定义项）。

多供应商候选方案（选定后再动 bashrc）：

| 方案 | 形态 | 适用 |
|---|---|---|
| A 按项目隔离 | 项目 `.claude/settings.local.json` 覆盖 base_url/model，优先级高于用户级 settings.json | 不同项目不同供应商 |
| B 网关聚合 | LiteLLM / one-api 单端点路由多上游 + discovery=1 | 一个会话内混用多供应商模型 |
| C 多 profile | `claude --settings ~/.claude/profiles/xxx.json` | 纯 CLI 按次切换 |

机器本地的全局层只有 shell（`~/.bashrc.local`）；用户级 settings.local.json 不存在（见「密钥放哪」）。

## 防线：pre-commit 钩子

`hooks/pre-commit`（bootstrap 的 post 阶段自动 symlink 到 `.git/hooks/`）在每次提交前扫描 staged 内容：

1. 与 `~/.bashrc.local` 中敏感变量的**真实值**精确匹配
2. 泛化正则匹配常见密钥形态（`sk-…`、`ghp_…`、`AKIA…` 等）

命中即拒绝提交。确属误报时手动 `git commit --no-verify` 绕过。

全局生效：bootstrap 的 post 阶段把钩子同步到 `~/.git-template/` 并设置
`git config --global init.templateDir`，此后本机 `git init` / `git clone` 的新仓库自动携带。

## 包布局

| 包 | 内容 |
|---|---|
| bash | .bashrc .bash_aliases .profile .fzf.bash |
| vim | .vimrc .vimrc.basic（nvim 共用基础配置） .vim/pack/bundle/opt/google_python_style（无 git 的本地插件） |
| nvim | .config/nvim（lazy.nvim + lazy-lock.json 锁版本） |
| tmux | .tmux.conf .tmux/bin/{battery_status.sh,toggle-theme} |
| git | .gitconfig .config/git/ignore |
| claude | .claude/{settings.json,CLAUDE.md,skills/,hooks/,plugins/config.json} |
| opencode | .config/opencode/{opencode.json,AGENTS.md,oh-my-opencode.json,package.json,skills/} |
| gh | .config/gh/config.yml（hosts.yml 含 token，不入库） |
| vscode | .config/Code/User/{settings.json,keybindings.json} |
| cursor | .config/Cursor/User/settings.json |
| ideavim | .ideavimrc |
| fcitx5 | .config/fcitx5/{config,profile,conf/notifications.conf} |
| misc | .selected_editor .xinputrc |

```bash
# 全部部署（bootstrap.sh 会自动执行）
cd ~/dotfiles && stow -t "$HOME" bash vim nvim tmux git claude opencode gh vscode cursor ideavim fcitx5 misc
```

注意：**不要用 `stow *`** —— 根下的 README/scripts/packages/legacy/ 不属于任何包。

### stow 已知陷阱

- 首次部署时若 home 已有同名真实文件，stow 会报冲突。确认内容一致后 `rm` 原文件再 stow，或用 `stow --adopt`。
- **`--adopt` 会用 home 文件内容覆盖仓库文件**（再建链接），只在两者一致时安全。

## 新机器三问（机器专属内容统一出口，不用改仓库）

| 需求 | 出口 |
|---|---|
| 改环境变量 / 密钥 | `~/.bashrc.local`（.bashrc 末尾自动 source，不入库） |
| 加机器专属别名/函数 | `~/.bash_aliases_$(hostname)`（存在即 source，不入库；参考 `legacy/.bash_aliases_local`） |
| 装工具 | `./bootstrap.sh`（缺什么它会检测） |

**自动降级约定**：所有路径 `$HOME` 化；所有工具引用带 `command -v`/文件存在性守卫——某工具没装，相关配置静默跳过，登录 shell 不报错。

**新机器检查清单**（应全部无输出）：
```bash
grep -rn '/home/fmh' ~/dotfiles --exclude-dir=.git --exclude-dir=legacy
```

**其他本机差异**：
- `.bashrc` 中 node18 / pi-node / opencode / pyenv / JBR 等 PATH 是本机安装位置，缺目录时无副作用，且均有存在性守卫。
- `~/.config/git/ignore` 全局忽略 `**/.claude/settings.local.json`。

## 自编译工具（不脚本化，见 bootstrap 提醒）

- **tmux**：`.tmux.conf` 需要 >=3.6（extended-keys / OSC52），22.04 的 apt 版只有 3.2a 会报 invalid option。自编译（本机装到 `~/.local/bin/tmux`）：

```bash
sudo apt install libevent-dev libncurses-dev bison pkg-config
curl -fsSL https://github.com/tmux/tmux/releases/download/3.7b/tmux-3.7b.tar.gz | tar xz
cd tmux-3.7b && ./configure && make && cp tmux ~/.local/bin/
```

- **nvim dev 版**：本机装在 `~/.local/bin/nvim`，按需从 release/源码获取。
- **YCM**：克隆后需编译 `cd ~/.vim/pack/vendor/start/YouCompleteMe && python3 install.py`。

## legacy/（参考，不部署）

- `legacy/windows/mini_vimrc` —— Windows 用 vim-plug 版配置
- `legacy/server/.bash_aliases_server` —— svr81 旧机器别名
- `legacy/.bash_aliases_local` —— 旧"local 机器"别名模板；现在机器专属别名放 `~/.bash_aliases_$(hostname)`

## 历史

- 旧 `sync_dotfiles.sh`（rsync 单向同步）已移除，由 stow + bootstrap.sh 取代。
- 旧分支 `master` / `wh608` / `svr81` 保留作历史参考。

## 截图

![myTerm-2022](./images/myTerm.png)

![myTerm-2024](./images/myTerm-2024-07-09-223536.png)
