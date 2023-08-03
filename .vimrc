" ================================
" fgg's vimrc (Linux machine)
" built: 2018-07-16
" update: Wed 25 May 2022 22:35:38
" ================================

set nocompatible                                " be IMproved

" " ALWAYS PUT PLUGINS FIRST PLACE
" " TO AVOID SOME SILLY MISTAKES;)
" " ================================Part-1: Plugins List======= {{{
call plug#begin('~/.vim/bundle')            " reuse the plugins dir
" "-------------------=== Code/Project navigation ===-------------
" Plug 'majutsushi/tagbar'                    " Class/module browser
Plug 'kshenoy/vim-signature'                " bookmark etc
Plug 'easymotion/vim-easymotion'            " quick move
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
" "-------------------=== vim outfit ===-------------------------------
Plug 'vim-airline/vim-airline'              " Lean & mean status/tabline
Plug 'vim-airline/vim-airline-themes'       " Themes for airline
Plug 'Lokaltog/powerline'                   " Powerline fonts plugin
Plug 'flazz/vim-colorschemes'               " Colorschemes
Plug 'jnurmine/Zenburn'                     " For good mood
Plug 'altercation/vim-colors-solarized'     " For good mood
" "-------------------=== tmux ===-------------------------------
Plug 'christoomey/vim-tmux-navigator'       " vim <-> tmux hopping
Plug 'edkolev/tmuxline.vim'                 " tmux status line
" "-------------------=== Coding enhancement ===-------------------
Plug 'airblade/vim-gitgutter'               " shows git diff and more
Plug 'tpope/vim-fugitive'                   " awsome git wrapper!
Plug 'tpope/vim-obsession'                  " for `vim -S` back to sessions
Plug 'tpope/vim-surround'                   " (), [], “”, XML tags, and more
Plug 'tpope/vim-repeat'                     " enhance . repeat
Plug 'tpope/vim-eunuch'                     " Vim sugar for UNIX shell commands
Plug 'scrooloose/nerdcommenter'             " code line/block commented
Plug 'Valloric/YouCompleteMe'               " all for completion
Plug 'dense-analysis/ale'                   " Linter
Plug 'mileszs/ack.vim'                      " cherrypick your strings
Plug 'junegunn/fzf', { 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips', { 'on': [] } | Plug 'honza/vim-snippets'
" "-------------------=== Python enhancement ===-------------------
Plug 'fisadev/vim-isort'                    " python import sorted
Plug 'hdima/Python-Syntax'                  " highlights for python
" Plug 'davidhalter/jedi-vim'                 " python auto-completion
Plug 'Vimjas/vim-python-pep8-indent'        " nicer indent for multiple lines
" "-------------------=== Wiki/markdown enhancement ===-------------------
Plug 'vimwiki/vimwiki'                      " for personal wiki
Plug 'mattn/calendar-vim'                   " Calendar match with vimwiki
Plug 'junegunn/goyo.vim'                    " distraction-free writing
Plug 'junegunn/limelight.vim'               " distraction-free writing couple
Plug 'godlygeek/tabular'                    " couple with vim-markdown
Plug 'plasticboy/vim-markdown'              " couple with vim-instant-markdown
Plug 'mzlogin/vim-markdown-toc'             " for table_of_content
Plug 'instant-markdown/vim-instant-markdown', {'for': ['markdown', 'markdown.pandoc']}
Plug 'vim-pandoc/vim-rmarkdown'             " RMarkdown Docs in Vim
Plug 'vim-pandoc/vim-pandoc'                " RMarkdown Docs in Vim
Plug 'vim-pandoc/vim-pandoc-syntax'         " RMarkdown Docs in Vim
" "-------------------=== Latex suppoert  ===-------------------
Plug 'lervag/vimtex'                        " for LaTeX files
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }  " live-preview out.pdf
" "-------------------=== Julia lang enhancement  ===-------------------
Plug 'JuliaEditorSupport/julia-vim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
" Plug 'roxma/nvim-completion-manager'  " optional, for auto-completion
" "-------------------=== C family enhancement ===-------------------
Plug 'fatih/vim-go'                         " for golang
" Plug 'rust-lang/rust.vim'                 " for rust
" Plug 'octol/vim-cpp-enhanced-highlight'   " extra highlights for cpp
" Plug 'derekwyatt/vim-fswitch'             " switch between *.h and *.cpp
" "-------------------=== other plugins ===-----------------------------
Plug 'jamessan/vim-gnupg'                   " transparent editting .gpg files
" "-------------------=== local plugins ===-----------------------------
" " Unmanaged local plugin (manually installed and update):
Plug '~/.vim/bundle/xterm-color-table.vim'
" " 中文跳转 (easymotion-like)
Plug '~/.vim/bundle/vim-PinyinSearch'
" Plug '~/.vim/bundle/vimim.vim'            " 实际上要放在 ./vim/plugin/ 才可
call plug#end()            " required

" " }}}
" " ================================Part-2: Colorscheme======== {{{
" " NOTE: syntax enable is needed
syntax enable
" " gvim (rarely used through)
if has('gui_running')
    set guioptions=     " no toolbar
    " set guifont=Lucida_Console:h9
    " colorscheme solarized
    " call togglebg#map("<F5>")
endif
" " }}}
" " ================================Part-3: Settings=========== {{{
" " allow variable syntax highlight approches instead of the default
filetype plugin on
syntax on
" " Highlight TODO, FIXME, NOTE, etc. (must not set before `syntax on`)
" " more here: https://stackoverflow.com/questions/6577579/task-tags-in-vim
if has("autocmd")
    if v:version > 701
    autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|HACK\|OPT\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
    endif
endif
hi Todo guifg=#0f4f4f guibg=#ffdfaf ctermfg=223 ctermbg=NONE gui=bold cterm=NONE
hi Info guifg=#0f4f4f guibg=#ffdfaf ctermfg=223 ctermbg=NONE gui=bold cterm=NONE
" " Do not use a mouse, otherwise :set mouse=n/v/i/a
set mouse=
" " backspace for del
set backspace=indent,eol,start
" " Split windows manners
set splitbelow
set splitright
" " Searching
set incsearch
set hlsearch
set ignorecase
set smartcase
" " UI settings
set laststatus=2
set ruler
set cursorline
set cursorcolumn
set number relativenumber
set showcmd
set wildmenu
set showmatch
set noshowmode
" " always keep cursor away 7 lines from the bottom
set scrolloff=7
set sidescrolloff=3
" " do not wrap the code
set nowrap
" " code fold
" " press Space to toggle the current fold open/close;
" " with fmd=manual, create a fold by visually selecting lines
" set foldmethod=manual
set foldmethod=marker
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" " do not fold when first startup vim
" set nofoldenable
" " History
set history=1024
set viminfo+=h  " do no store searches
" " utf8 encoding
set encoding=utf-8
" " tab and space
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
" " (default 4000, i.e., 4 seconds)
set updatetime=1000
" " markdown concealed text hidden
set conceallevel=1
" " }}}
" " ================================Part-4: Leader Commands==== {{{
" " leader set to the comma, but the <space> also very helpful
let mapleader=","

" " Not so grace shotcuts to toggle themes dark/bright 
nnoremap <leader>tt :colo Tomorrow<cr>
nnoremap <leader>tn :colo Tomorrow-Night<cr>
" " quick save/exit etc
nnoremap <leader>w :w<cr>
nnoremap <space>w :Gwrite<cr>
nnoremap <space>c :Gcommit -v<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>
" " ---------------------------------------------------------
" " shotcut to edit ~/_vimrc, and update it to local git repo
nnoremap <leader>v :tabnew <bar> :e $MYVIMRC<cr>
nnoremap <space>v :sp $MYVIMRC<cr>
" groups of specific commands to update .vimrc to git repo
" CC = change to directory of Current file
command CC cd %:p:h <bar> :e %
" Svrc means saveas current file to someother dir
command Svrc sav! ~/dataGroup/gitrepos/dotfiles/.vimrc
" ---------------------------------------------------------
" " common rule were: splitright & splitbelow
" " but sometimes need to split on leftabove or above
" nnoremap <leader>lf :leftabove split
nnoremap <leader>up :above split
" when the "+gp is not working, toggle the paste mode:
" then change to insert mode to paste the code,
" after pasting is done, toggle it back (to support 'auto-indent' again)
set pastetoggle=<F2>
" yanking/pasting with system clipboard
" pasting from sys clipboard to vim
nnoremap <space>p "+gp
" " yank to sys clipboard only in Visual Mode
vnoremap <space>y "+y
" " " when the "+gp is not working, toggle the paste mode:
" " then change to insert mode to paste the code,
" " after pasting is done, toggle it back (to support 'auto-indent' again)
set pastetoggle=<F2>
" " shotcuts to new tabs and moving around
nnoremap <space>] :tabn<cr>
nnoremap <space>[ :tabp<cr>
" tmuxline snapshot file-saved
nnoremap <leader>tx :TmuxlineSnapshot! ~/.vim/colors/tx-airline<cr> :echo "***tx-snapshot saved***"<cr>
" The "e" flag tells ":substitute" that not finding a match is not an error.
" strip trailing whitespace (,,t)
nnoremap <leader><leader>t :%s/\s\+$//ge<cr>
" quick select buffer and delete it | deprecated, already has fzf
" nnoremap <leader>bn :bnext<cr>
" nnoremap <leader>bp :bprevious<cr>
" nnoremap <leader>bf :ls<cr>
" nnoremap <leader>bd :bd<cr>
" turn off highlights
nnoremap <space><space> :nohlsearch<cr>
" windows/panes resize
nnoremap <silent> <Space>+ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Space>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
" " close quickfix/local/preview window
" nnoremap <space>lo :cclose<cr>
" nnoremap <space>lc :lclose<cr>
" nnoremap <space>pc :pclose<cr>
" " fzf shotcut
imap <c-x><c-o> <plug>(fzf-complete-line)
map <space>b :Buffers<cr>
map <space>f :Files<cr>
map <space>g :GFiles<cr>
map <space>t :Tags<cr>
" " -------------------------------------------------------------------
" " Start recording keystrokes by typing qq.
" " End recording with q (first press Escape if you are in insert mode).
" " Play the recorded keystrokes by hitting space.
" " Suppose you have a macro which operates on the text in a single line.
" " You can run the macro on each line in a visual selection in a single operation:
" " Visually select some lines (for example, type vip to select the current paragraph).
" " Type :normal @q to run the macro from register q on each line.
" " -------------------------------------------------------------------
" " Open help at vertical pane
nnoremap <Space>h :vert help 
" " alternative way to back to normal mode
inoremap jk <ESC>
" " groups of abbreviate
" " insert the datetime
" " insert mode by typing 'dts' >> 'Sat 28 Aug 2021 09:45:56'
iab dts <c-r>=strftime("%a %d %b %Y %T")<cr>
iab dte <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
" " Em dash symbol
iab emdash —
" " Emoji shortcuts
ab :wilkyway: 🌌
ab :rocket: 🚀
ab :check: ✅
ab :warning: ⚠️
ab :bulb: 💡
ab :pushpin: 📌
ab :bomb: 💣
ab :pill: 💊
ab :construction: 🚧
ab :pencil: 📝
ab :point_right: 👉
ab :book: 📖
ab :link: 🔗
ab :wrench: 🔧
ab :callme: 🤙📞
ab :email: 📧
ab :computer: 💻
ab :redheart: ❤️
ab :wtf: 😱
ab :toj: 😂
ab :thanks: 😜
ab :kidding: 🙄
ab :weary: 😩
ab :robot: 🤖
ab :panda: 🐼
ab :penguin: 🐧
ab :globe: 🌏
ab :cherry: 🍒
ab :cheers: 🍻
ab :football: ⚽
ab :China: 🇨🇳
ab :usa: 🇺🇸
ab :notry: Do. Or do not. There is no try 😏
" " }}}
" " ================================Part-5: Plugins Configs==== {{{
" " vim-plug update itself using PlugUpgrade command --- {{{
command! PU PlugUpdate | PlugUpgrade
" " }}}

" " vim-PinyinSearch settings -------------- {{{
" let g:jedi#popup_on_dot = 0
" let g:jedi#show_call_signatures = "1"
" " " split panes commands
" let g:jedi#use_tabs_not_buffers = 1
" let g:jedi#use_splits_not_buffers = "left"
" " " go-to commands
" let g:jedi#goto_command = "<leader>g"
" " let g:jedi#goto_assignments_command = "<leader>d"
" let g:jedi#goto_stubs_command = "<leader>s"
" let g:jedi#goto_definitions_command = "<leader>j"
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "<C-n>"
" let g:jedi#rename_command = "<leader>r"
" " }}}

" " vim-PinyinSearch settings -------------- {{{
let g:PinyinSearch_Dict = $HOME . '/.vim/bundle/vim-PinyinSearch/PinyinSearch.dict'
nnoremap ? :call PinyinSearch()<CR>
" " I suggest using '?' to search Pinyin
" " (since we have 'N', why using ? to search backward)
nnoremap <Leader>pn :call PinyinNext()<CR>
" " }}}

" " vimim.vim settings -------------- {{{
" let g:Vimim_map='tab_as_gi'
" let g:vimim_shuangpin = 0
" let g:vimim_punctuation = 2
" let g:vimim_mode = 'dynamic'
" " NOTE 必须将 vimim.vim 和 词库文件如 vimim.pinyin.txt
" " 一起放在 .vim/plugin/ 目录下
" let g:vimim_toggle = 'pinyin,google,sogou'
" " }}}

" " Julia-vim settings --- {{{
" " julia version >= 1.0
let g:default_julia_version = '1.0'
" " language server linting etc | NOTE that this is not good for 'old' machine, for the cpu sake.
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_serverCommands = {
"             \   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
"             \       using LanguageServer;
"             \       using Pkg;
"             \       import StaticLint;
"             \       import SymbolServer;
"             \       env_path = dirname(Pkg.Types.Context().env.project_file);
"             \
"             \       server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "");
"             \       server.runlinter = true;
"             \       run(server);
"             \   ']
"             \ }
" " block-wise jump
runtime macros/matchit.vim
let g:julia_indent_align_import=1
let g:julia_indent_align_brackets=1
hi link juliaParDelim Delimiter
hi link juliaSemicolon Operator
hi link juliaFunctionCall Identifier
" " }}}

" " pandoc, pandoc_syntax --- {{{
let g:pandoc#spell#enabled = 0
" " }}}

" " vimwiki ----------- {{{
" " vimwiki with markdwon support (as default format)
let g:vimwiki_ext2syntax={'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown', '.rmd': 'markdown'}
" "
" " my wiki path >>> [count]<Leader>ww | [count]<Leader>wt (new tab)
" " <Leader>ww opens the first wiki from |g:vimwiki_list| if no wiki is
" " open. Otherwise the index of the currently active wiki is opened.
" " 1<Leader>ww opens the first wiki from |g:vimwiki_list|.
" " 2<Leader>ww opens the second wiki from |g:vimwiki_list|.
" " 3<Leader>ww opens the third wiki from |g:vimwiki_list|.
" " etc.
" " <Leader>ws: List and select available wikis.
" "
let g:vimwiki_list = [
    \ {'path': '~/VimWiki', 'syntax': 'markdown', 'ext': '.md',
    \  'index': 'index', 'auto_export': 0, 'automatic_nested_syntaxes':1,
    \  'path_html': '~/VimWiki/draft_html/',
    \  'template_ext': '.html',
    \  'template_default': 'markdown',
    \  'template_path': '~/VimWiki/template/',
    \ },
    \ ]
" " \  'custom_wiki2html': '~/VimWiki/wiki2html.sh',
" " Calendar + Diary
let g:vimwiki_use_calendar=1
" " fancy todo listsyms
let g:vimwiki_listsyms = '✗○◐●✓'
" " some remaps
" " open Link in VSplite
nmap <leader>lh <Plug>VimwikiSplitLink
nmap <leader>lv <Plug>VimwikiVSplitLink
" " }}}
 
" " goyo and limelight ------ {{{
nnoremap <C-g> :Goyo<CR>
let g:goyo_linenr = 1
let g:goyo_width = 80
" let g:goyo_height = 85%
" " }}}

" " NERDTree ------- {{{
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeIgnore=[
    \ '\.sw[po]$', '\.vim$', '\~$',
    \ '__init__.py',
    \ '^t[e]mp$[[dir]]',
    \ '^__pycache__$[[dir]]',
    \ '.egg-info$[[dir]]',
    \ ]
augroup ProjectDrawer
    " " Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
    " " Start NERDTree when Vim starts with a directory argument.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
    " " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
" " }}}

" " Nerdtree like using netrw --- {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
" let g:netrw_altv = 1
let g:netrw_winsize = 18
" let g:netrw_list_hide = &wildignore
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" " }}}

" " pandoc, pandoc_syntax --- {{{
let g:pandoc#spell#enabled = 0
" " }}}

" " vimwiki ----------- {{{
" " vimwiki with markdwon support (as default format)
let g:vimwiki_ext2syntax={'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown', '.rmd': 'markdown'}
" "
" " my wiki path >>> [count]<Leader>ww | [count]<Leader>wt (new tab)
" " <Leader>ww opens the first wiki from |g:vimwiki_list| if no wiki is
" " open. Otherwise the index of the currently active wiki is opened.
" " 1<Leader>ww opens the first wiki from |g:vimwiki_list|.
" " 2<Leader>ww opens the second wiki from |g:vimwiki_list|.
" " 3<Leader>ww opens the third wiki from |g:vimwiki_list|.
" " etc.
" " <Leader>ws: List and select available wikis.
" "
let g:vimwiki_list = [
    \ {'path': '~/VimWiki', 'syntax': 'markdown', 'ext': '.md',
    \  'index': 'index', 'auto_export': 0, 'automatic_nested_syntaxes':1,
    \  'path_html': '~/VimWiki/draft_html/',
    \  'template_ext': '.html',
    \  'template_default': 'markdown',
    \  'template_path': '~/VimWiki/template/',
    \ },
    \ ]
" " \  'custom_wiki2html': '~/VimWiki/wiki2html.sh',
" " Calendar + Diary
let g:vimwiki_use_calendar=1
" " fancy todo listsyms
let g:vimwiki_listsyms = '✗○◐●✓'
" " some remaps
" " open Link in VSplite
nmap <leader>lh <Plug>VimwikiSplitLink
nmap <leader>lv <Plug>VimwikiVSplitLink
" " }}}
 
" " goyo and limelight ------ {{{
nnoremap <C-g> :Goyo<CR>
let g:goyo_linenr = 1
let g:goyo_width = 80
" let g:goyo_height = 85%
" " }}}

" " NERDTree ------- {{{
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeIgnore=[
    \ '\.sw[po]$', '\.vim$', '\~$',
    \ '__init__.py',
    \ '^t[e]mp$[[dir]]',
    \ '^__pycache__$[[dir]]',
    \ '.egg-info$[[dir]]',
    \ ]
augroup ProjectDrawer
    " " Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
    " " Start NERDTree when Vim starts with a directory argument.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
    " " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
" " }}}

" " Nerdtree like using netrw --- {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
" let g:netrw_altv = 1
let g:netrw_winsize = 18
" let g:netrw_list_hide = &wildignore
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" " }}}

let g:vim_isort_map = '<C-i>'
" " Or disable the mapping with this:
" let g:vim_isort_map = ''
" " You can configure overrides for isort's config parameters:
" let g:vim_isort_config_overrides = {
"     \ 'include_trailing_comma': 1,
"     \ 'multi_line_output': 3}
" " so if isort is installed under Python 3:
let g:vim_isort_python_version = 'python3'
" " }}}

" " Ack key-bind----------------- {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" " do not auto-jump (ack!) to the first result
nnoremap <leader>a :Ack!<Space>
command Todo Ack! 'TODO|FIXME|CHANGED|HACK'
command Info Ack! 'NOTE|INFO|IDEA'
" " }}}

" " vim-go ---------------------- {{{
let g:go_list_type = "locationlist"
let g:go_list_type_commands = {"GoBuild": "quickfix"}
" let g:go_list_autoclose = 1
" using terminal feature
let g:go_term_enabled = 1
" let g:go_term_mode = "vsplit"
let g:go_term_mode = "split"
let g:go_term_height = 20
let g:go_fmt_autosave = 1
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_deadline = "5s"
let g:go_def_mapping_enabled = 1
let g:go_def_reuse_buffer = 1
let g:go_gopls_enabled = 1
let g:go_rename_command = 'gopls'
let g:go_fmt_command = "goimports"
" let g:go_fmt_fail_silently = 1
" let g:go_addtags_transform = "camelcase"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_auto_type_info = 1
" let g:go_auto_sameids = 1
" " }}}

" " tmuxline -------------------- {{{
let g:tmuxline_theme = 'zenburn'
let g:airline#extensions#tmuxline#enabled = 1
let g:tmuxline_powerline_separators = 0
" let g:tmuxline_preset = '' "see autoload/tmuxline/preset/*
" " NOTE that the status right section was override by tmux.conf for 'weather' to work
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#[fg=green]\u2206#(uptime | cut -d " " -f 4,5 | cut -d "," -f 1)',
      \'c'    : '',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'y'    : ['#{weather}', '%R','%a', '%F' ],
      \'z'    : '#H'}
" " }}}

" " ctags ----------------------- {{{
" " look in the current directory for 'tags',
" " and work up the tree towards root until one is found.
set tags=./tags;/
" set tags=./tags;$HOME
" " NOTE: already setup goto with YcmCompleter, seems this is overlap
" " Wed 01 Jan 2020 18:45:52
" " generate tag file, so we can Ctrl-] to goto definitions
" nnoremap <F9> :!ctags -R<cr>
" " }}}

" " fzf as vim-plugin ----------- {{{
" " For multi-platform sake, just install the fzf in ~/.fzf
set rtp+=~/.fzf
let g:fzf_layout = {'down': '~40%'}
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" " Enable per-command history.
" " CTRL-N and CTRL-P will be automatically bound to next-history and
" " previous-history instead of down and up. If you don't like the change,
" " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" " Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" " }}}

" " vim gitgutter -------------- {{{
let g:gitgutter_signs = 1
let g:gitgutter_max_signs = 500
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_preview_win_floating=1
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
" " }}}

" " vim-instant-markdown-preview ------- {{{
" " NOTE that npm install instant_markdown_d failed with
" " with the newest version of node.js (v16.*), using the
" " snap version of node (v14) or try 'fnm install'

" " shortcut to preview
command MDPV :InstantMarkdownPreview
" " let it be slow? (real-time update seems great)
" let g:instant_markdown_slow = 0
" let g:instant_markdown_slow = 1
" " manual trigger the preview window
let g:instant_markdown_autostart = 0
" " uses MathJax
let g:instant_markdown_mathjax = 1
" " only if not want to load images, stylesheets etc.
let g:instant_markdown_allow_external_content = 1
" " to allow scripts to run
let g:instant_markdown_allow_unsafe_content = 1
" " new in ver0.2.0 and latter
" " choose a custom port instead of default 8090
" let g:instant_markdown_port = 8888
" " auto-scrolls to Where the cursor is positioned
let g:instant_markdown_autoscroll = 1
" " choose a custom browser
let g:instant_markdown_browser = "firefox --new-window"
" " let's just keep it on local for now
" let g:instant_markdown_open_to_the_world = 1
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
" " }}}

" " vim-markdown --------------- {{{
" " fold style
let g:vim_markdown_folding_style_pythonic = 1
" " To prevent foldtext from being set
let g:vim_markdown_override_foldtext = 0
" " set header folding level
let g:vim_markdown_folding_level = 6
" " no default key mappings
" let g:vim_markdown_no_default_key_mapping = 1
" " enable TOC windown auto-fit
let g:vim_markdown_toc_autofit = 1
" " text emphasis resriction to single line
" let g:vim_markdown_emphasis_multiline = 0
" " syntax concealing
" " disable math conceal with LaTex math syntax enable
" let g:tex_conceal = ""
let g:vim_markdown_math = 1
" " do not require .md extensions for Markdown links
let g:vim_markdown_no_extensions_in_markdown = 1
" " how to open new files [tab, vsplit, hsplit, current]
let g:vim_markdown_edit_url_in = 'hsplit'
" " create interal links and jump with `ge`
" let g:vim_markdown_follow_anchor = 1
" " go to next header
map ]] <Plug>Markdown_MoveToNextHeader
map [[ <Plug>Markdown_MoveToNextHeader
" " }}}

" " vim markdown preview -------- {{{
" let vim_markdown_preview_github=1
" let vim_markdown_preview_pandoc=1
" let vim_markdown_preview_hotkey='<C-m>'
" let vim_markdown_preview_browser='firefox'
" let vim_markdown_preview_use_xdg_open=1
" " }}}

" " python-syntax highlight ----- {{{
let python_highlight_all = 1
" " py_PEP8 indent settings
let g:python_pep8_indent_multiline_string = 1
let g:python_pep8_indent_hang_closing = 1
" " }}}

" " UltiSnips settings --------- {{{
" " handle the conflit with YCM
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" " include self-define Snippets
" let g:UltiSnipsSnippetDir="$HOME/.vim/bundle/ultisnips"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "fggsnippets"]
" " UltiSinpsUsePythonVersion
let g:UltiSinpsUsePythonVersion = 3
let g:UltiSnipsNoPythonWarning = 1
" " }}}

" " vim-tmux-navigator --------- {{{
" " disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
" " Write all buffers before navigating from vim to tmux pane
" " value:1 -- :update (current buffer iff changed);
" "       2 -- :wall (write all bufffer)
" let g:tmux_navigator_save_on_switch = 1
" " match with Tmux-side of vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
" " }}}

" " nerdcommenter -------------- {{{
" " Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" " Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" " Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_cpp = 1
" " Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" " Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" " Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" " }}}

" " cpp highlight -------------- {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
" " disable user difined funcs highlight
let g:cpp_no_function_highlight = 1
" " }}}

" " vim-signature -------------- {{{
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }
" " }}}

" " YCM settings --------------- {{{
" " *youcompleteme-configuring-through-vim-options* ---------------------
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/ycm_extra_conf/global_extra_conf.py'
" " *youcompleteme-configuring-through-vim-options* end------------------
let g:ycm_server_python_interpreter = '/usr/bin/python3'
" " 允许vim加载.ycm_confirm_extra_conf.py文件，不再提示
let g:ycm_confirm_extra_conf = 0
" " 补全功能在注释中有效
let g:ycm_complete_in_comments = 1
" " 在注释和字符串中获取标识符
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" " show the full function prototype and overload
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" " 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" " 语法关键字补全
let g:ycm_seed_indentifiers_with_syntax=1
" " 选择补全选项的移动方向
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" " 显示详细诊断信息
let g:ycm_key_detailed_diagnostics = '<space>k'

" " 引入 C++ 标准库tags
" set tags+=/data/misc/software/misc./vim/stdcpp.tags
" let g:ycm_collect_identifiers_from_tags_files = 0
" " 补全内容不以分割子窗口出现，只显示补全列表
" set completeopt-=preview

" " ycmcompleter subcommands, e.g., goto, fixit etc. | happy reading source code
" " This command tries to perform the 'most sensible' GoTo operation it can.
nnoremap <leader>g :YcmCompleter GoTo<CR>
" " Looks up the identifier under the cursor and populates with the quickfix list
nnoremap <leader>r :YcmCompleter GoToReferences<CR>
" " Looks up the symbol under the cursor and jumps to its definition.
nnoremap <leader>j :YcmCompleter GoToDefinition<CR>
" " Displays the preview window populated with quick info about the identifier under the cursor.
nnoremap <leader>k :YcmCompleter GetDoc<CR>
" " }}}

" " EasyMotion ----------------- {{{
" " disable default prefix <leader><leader>
let g:EasyMotion_do_mapping=0
" " case insensitive on
let g:EasyMotion_smartcase=1
" " for Chinese
" let g:EasyMotion_use_Chinese=1
" " find motions: line motions
map <leader>f <Plug>(easymotion-f)
map <leader>F <Plug>(easymotion-F)
" " }}}

" " tagbar settings ------------ {{{
" " tagbar needs Ctags/universe-ctags, and much more useful in larger project
" let g:airline#extensions#tagbar#enabled = 1
" let g:tagbar_autofocus=1
" let g:tagbar_width=28
" let g:tagbar_left=1
" let g:tagbar_sort=0
" let g:tagbar_show_linenumbers = 2     " show relative nu
" let g:tagbar_expand = 1
" " remap keys | toggle tagbar | Jump directly to tagbar
" nnoremap <space><space>b :TagbarToggle<CR>
" nnoremap <space>j :TagbarOpen fj<CR>
" " }}}

" " vim-indent-guides ---------- {{{
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
" " leader + i to turn on/off the indent_guide
nmap <silent> <leader>> <Plug>IndentGuidesToggle
" " }}}

" " airline settings ----------- {{{
let g:airline#extensions#tabline = 1
let g:airline_theme='zenburn'
let g:airline_extensions=['branch', 'ale', 'tabline', 'obsession']
" let g:airline_extensions=['branch', 'tagbar', 'ale', 'tabline', 'obsession']
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" " airline symbols, install the fonts-powerline first
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
" " display the tail of the filename
let g:airline#extensions#tabline#formatter = 'unique_tail'
" " configure symbol used to represent close button >
let g:airline#extensions#tabline#close_symbol = 'X'
" " configure the title text for quickfix buffers >
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
" " configure the title text for location list buffers >
let g:airline#extensions#quickfix#location_text = 'Location'
" " vim-fugitive
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
" let g:airline#extensions#branch#format = 0
" " vim-Obsession
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#obsession#indicator_text = '$'
" " }}}

" " ale settings --------------- {{{
let g:ale_enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \   'cpp': ['libclang', 'gcc', 'clangd'],
            \   'go': ['gobuild', 'govet', 'gofmt'],
            \   'c': ['clang', 'gcc'],
            \   'rust': ['cargo', 'rustc'],
            \   'python': ['flake8'],
            \   'tex': 'all',
            \}
" \   'julia': ['languageserver']
" let g:ale_julia_executable='/usr/local/bin/julia'
let g:ale_python_flake8_use_global = 1
let g:ale_fixers = {
            \   'python': ['yapf', 'autopep8'],
            \   'sql': ['pgformatter'],
            \}
" let g:ale_fix_on_save = 1
" " Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)
" " shell scripts static syntax linter
" let g:ale_sh_shellcheck_executable = 'shellcheck'
" let g:ale_sh_shellcheck_dialect = 'auto'
" let g:ale_set_signs = 1
" let g:ale_sign_column_always = 1
" let g:ale_echo_cursor = 1
" let g:ale_open_list = 1
" let g:ale_set_loclist = 1
" let g:ale_set_quickfix = 0
" " This can be useful if you are combining ALE with
" " some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 0
" " Show 10 lines of errors (default: 10)
let g:ale_list_window_size = 10
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" " ale movements
nmap <silent> <C-p> <Plug>(ale_previous)
nmap <silent> <C-n> <Plug>(ale_next)
" " }}}

" " vim-gnugp settings --------------- {{{
let g:GPGPreferArmor=1
let g:GPGDefaultRecipients=["fanmhgg@gmail.com"]
" " }}}

" " vimtex/lively-preview --- {{{
" let g:vimtex_compiler_latexmk_engines = 'xelatex'
if !exists('g:ycm_semantic_triggers')
let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
let g:livepreview_engine = 'xelatex'
let g:livepreview_cursorhold_recompile = 0
let g:ale_textlint_executable = 'textlint'
let g:vimtex_syntax_conceal = {
      \ 'accents': 1,
      \ 'cites': 1,
      \ 'fancy': 1,
      \ 'greek': 1,
      \ 'math_bounds': 1,
      \ 'math_delimiters': 1,
      \ 'math_fracs': 1,
      \ 'math_super_sub': 1,
      \ 'math_symbols': 1,
      \ 'sections': 0,
      \ 'styles': 0,
      \}
" " }}}

" " =================================================================== }}}
" " ================================Part-6: Autocmd Groups===== {{{
" " for *.sql  ------ {{{
augroup pgformatter_sql
    au!
    au FileType sql setl formatprg=/usr/local/bin/pg_format\ -
augroup END
" " }}}

" " for *.jl  ------ {{{
augroup LanguageClient_config
    au!
    au User LanguageClientStarted setlocal signcolumn=yes
    au User LanguageClientStopped setlocal signcolumn=auto
augroup END
" " }}}

" " for vimwiki md pandoc ------ {{{
augroup pandoc_syntax
    au! FileType vimwiki set syntax=markdown.pandoc
    au! BufRead,BufNewFile vimwiki set noimdisable
    au! BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set noimdisable
augroup END
" " }}}

" " for html ------ {{{
augroup html_format
    au!
    au BufNewFile,BufRead *.html set filetype=html
    au FileType html set softtabstop=2
    au FileType html set shiftwidth=2
augroup END
" " }}}

" " for markdown ------ {{{
augroup markdown_format
    au!
    au User GoyoEnter Limelight
    au User GoyoLeave Limelight!
    au BufNewFile,BufRead *.md set filetype=markdown
    au FileType markdown set nowrap
    au FileType markdown setlocal textwidth=79
    au FileType markdown setlocal conceallevel=2
    au FileType markdown set cursorline
    au FileType markdown set cursorcolumn
augroup END
" " }}}

" " vim to edit the gpg encrypted file -------------------------------------- {{{
" " augroup for edit *.gpg encrypted files
" " Don't save backups of *.gpg files
" set backupskip+=*.gpg
" " To avoid that parts of the file is saved to .viminfo when yanking or deleting, empty the viminfo option
" set viminfo=
" augroup filetype_gpg
"     au!
"     " Disable swap files, and set binary file format before reading the file
"     au BufReadPre,FileReadPre *.gpg
"         \ setlocal noswapfile bin
"     " Decrypt the contents after reading the file, reset binary file format and run any BufReadPost
"     " autocmds matching the file name without the .gpg extension
"     au BufReadPost,FileReadPost *.gpg
"         \ execute "'[,']!gpg --decrypt --default-recipient-self" |
"         \ setlocal nobin |
"         \ execute "doautocmd BufReadPost " . expand("%:r")
"     " Set binary file format and encrypt the contents before writing the file
"     au BufWritePre,FileWritePre *.gpg
"         \ setlocal bin |
"         \ '[,']!gpg --encrypt --default-recipient-self
"     " After writing the file, do an :undo to revert the encryption in the buffer, and reset binary file format
"     au BufWritePost,FileWritePost *.gpg
"         \ silent u |
"         \ setlocal nobin
" augroup END
" " }}}

" " golang mappings ---------------------------- {{{
augroup golang
    au!
    au FileType go nnoremap <space>r <Plug>(go-run)
    au FileType go nnoremap <space>t <Plug>(go-test)
    au FileType go nnoremap <space>b  <Plug>(go-build)
    au FileType go nnoremap <Leader>i <Plug>(go-info)
    au FileType go nnoremap <leader>g <Plug>(go-def-vertical)
    au FileType go nnoremap <leader>r <Plug>(go-rename)
    au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END
" " }}}

" " vim-emoji mappings ---------------------------- {{{
" " only one completefunc working at a time, have to make way for YCM
" set completefunc=emoji#complete
" " replace :emoji_name: into Emojis
" %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
" " emoji for gitgutter signs
" let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
" let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
" let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
" let g:gitgutter_sign_modified_removed = emoji#for('collision')
" " }}}

" " vimscript file settings -------------- {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
" " }}}

" " UltiSnips set to load on nothing --- {{{
" " Plug 'SirVer/ultisnips', { 'on': [] }
" " Only load it when edit *.py file
augroup load_ultisnips
  autocmd!
  autocmd BufEnter,BufNewFile,BufRead *.md,*.py call plug#load('ultisnips')
              \| autocmd! load_ultisnips
augroup END
" " }}}

" " highlight 'long' lines(>= 79 symbols) ------- {{{
augroup filefmt_autocmds
    au!
    au FileType python,sh,c,cpp,julia,md,vimwiki,go,tex highlight Excess ctermbg=DarkGrey guibg=Black
    au FileType python,sh,c,cpp,julia,md,vimwiki,go,tex match Excess /\%80v.*/
    au FileType python,sh,c,cpp,julia,md,vimwiki,go,tex set nowrap
    au FileType python,sh,c,cpp,julia,md,vimwiki,go,tex set colorcolumn=79
    " auto begin in newline when exceed 79 chars when edit these filetypes
    au FileType python,sh,c,cpp,julia,md,vimwiki,go,tex setlocal textwidth=79 formatoptions+=t
    " gp for Chinese characters with formatoptions+=mM
    au FileType python,sh,julia,md,vimwiki,tex setlocal textwidth=79 formatoptions+=tmM
    " Don't add the comment prefix when I hit enter or o/O on a comment line
    au FileType python,sh,c,cpp,julia,md,vimwiki,vim,go,tex setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " " do not popup docstring windown when using jedi completion
    " au FileType python setlocal completeopt-=preview
augroup END
" " }}}

" " make change in vimrc working immediately --- {{{
augroup autosrc
    au! BufWritePost $MYVIMRC source % | echom "Reload " . $MYVIMRC
augroup END
" " }}}
