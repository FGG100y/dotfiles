local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "selimacerbas/markdown-preview.nvim",
    dependencies = { "selimacerbas/live-server.nvim" },
    config = function()
      require("markdown_preview").setup({
        -- xdg-open 被 jobstart 直接拉起会静默失败 (neovim/neovim#29932)；
        -- 且本机 nvim 常跑在 SSH/tmux 里没有 DISPLAY —— 用 bash 包一层并显式指定 :0。
        -- 若 shell 里已 export DISPLAY，可去掉 "DISPLAY=:0 " 前缀。
        browser = { "bash", "-c", 'DISPLAY=:0 xdg-open "$0" >/dev/null 2>&1' },
        -- 启动/重启预览时始终在 nvim 里打印 URL，浏览器打不开也能手动访问
        hooks = {
          on_start = function(url)
            vim.notify("Markdown Preview: " .. url, vim.log.levels.INFO)
          end,
        },
      })
    end,
  },
  {
    "tpope/vim-vinegar",
    keys = {
      { "-", "<Plug>VinegarUp", desc = "Vinegar: go to directory listing" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    -- 不懒加载：gitsigns 要挂在每个 git 文件上，官方推荐启动即加载；
    -- 实测启动开销仅 ~75ms，懒加载省的那点时间抵不上首次打开文件的 attach 延迟
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "+" },
          change       = { text = "│" },
          delete       = { text = "▁" },
          topdelete    = { text = "▔" },
          changedelete = { text = "~" },
        },
        signs_staged = { -- 已暂存改动用同一套形状，仅颜色不同
          add          = { text = "+" },
          change       = { text = "│" },
          delete       = { text = "▁" },
          topdelete    = { text = "▔" },
          changedelete = { text = "~" },
        },
        numhl = false,  -- 行号不高亮
        linehl = false, -- 整行不高亮，保持清爽
        signs_staged_enable = true, -- 同时显示已 git add 暂存的改动（默认只显示未暂存）
        current_line_blame = false, -- 光标行 blame 默认关，需要时 <leader>hb
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend("force", { buffer = bufnr }, opts or {})
            vim.keymap.set(mode, lhs, rhs, opts)
          end
          -- 跳转 hunk（沿用 gitgutter 的 ]c/[c，无需改肌肉记忆）
          map("n", "]c", gs.next_hunk, { desc = "Gitsigns: next hunk" })
          map("n", "[c", gs.prev_hunk, { desc = "Gitsigns: prev hunk" })
          -- hunk 操作
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Gitsigns: stage hunk" })
          map("n", "<leader>hu", gs.reset_hunk, { desc = "Gitsigns: reset hunk" })
          map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
            { desc = "Gitsigns: stage selection" })
          map("v", "<leader>hu", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
            { desc = "Gitsigns: reset selection" })
          -- 预览 / blame
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Gitsigns: preview hunk" })
          map("n", "<leader>hb", function() gs.blame_line { full = true } end, { desc = "Gitsigns: blame line" })
          -- 选中当前 hunk 的文本对象
          map({ "o", "x" }, "ih", gs.select_hunk, { desc = "Gitsigns: select hunk" })
        end,
      })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    -- tmux 侧已在 ~/.tmux.conf:116-136 配好（is_vim 正则含 nvim，无需改动）。
    -- <C-h/j/k/l>：优先切 vim 分屏，切不动则转发给 tmux 切 pane；<C-\> 回到上一个 pane。
    -- 不在 tmux 里运行时会自动退化为纯 vim 分屏切换。
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp",
      "TmuxNavigateRight", "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Tmux: navigate left" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Tmux: navigate down" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Tmux: navigate up" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Tmux: navigate right" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Tmux: last pane" },
    },
  },
})
