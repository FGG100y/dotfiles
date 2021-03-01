" ================================
" fgg's vimrc (home machine)
" built: 2018-07-16
" update: Tue 23 Feb 2021 22:24:45
" ================================
" TODO: try soft link to sync the dotfiles to fmhrepos

set nocompatible                                " be iMproved

" ALWAYS PUT PLUGINS FIRST PLACE
" TO ADVOID SOME SILLY MISTAKES.
" #############################
"  Part-1:  Plugins ---------- {{{
" #############################
filetype off                                    " required
set runtimepath+=$HOME/.vim/bundle/Vundle.vim/          " set the runtime path to include Vundle and initialize
call vundle#begin()
" NOTE: all the Plugins which is managed by Vundle must lie between
" vundle#begin() and vundle#end

    "-------------------=== Vundle itself ===-------------
    Plugin 'VundleVim/Vundle.vim'               " let Vundle manage Vundle, required
    "-------------------=== Code/Project navigation ===-------------
    Plugin 'majutsushi/tagbar'                  " Class/module browser
    Plugin 'kshenoy/vim-signature'              " bookmark etc
    " Plugin 'scrooloose/nerdtree'                " Project and file navigation
    "-------------------=== vim outfit ===-------------------------------
    Plugin 'vim-airline/vim-airline'            " Lean & mean status/tabline for vim
    Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
    Plugin 'Lokaltog/powerline'                 " Powerline fonts plugin
    Plugin 'flazz/vim-colorschemes'             " Colorschemes
    Plugin 'jnurmine/Zenburn'                   " For good mood
    Plugin 'altercation/vim-colors-solarized'   " For good mood
    " Plugin 'junegunn/vim-emoji'                 " Also for good mood, while conflict to YCM
    "-------------------=== tmux ===-------------------------------
    Plugin 'christoomey/vim-tmux-navigator'     " move to vim in tmux, it will take over and vice verse
    Plugin 'edkolev/tmuxline.vim'
    "-------------------=== Snippets support ===--------------------
    Plugin 'SirVer/ultisnips'                   " snippets management/engine
    Plugin 'honza/vim-snippets'                 " snippets repo
    "-------------------=== Languages support ===-------------------
    Plugin 'tpope/vim-fugitive'                 " awsome git wrapper!
    Plugin 'tpope/vim-obsession'                " :mksession --> :Obsess || :source or vim -S back to session.vim
    Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
    Plugin 'tpope/vim-repeat'                   " enhance . repeat
    Plugin 'mileszs/ack.vim'                    " cherrypick your strings
    Plugin 'airblade/vim-gitgutter'             " shows a git diff in the sign column (i.e., gutter)
    Plugin 'easymotion/vim-easymotion'
    Plugin 'scrooloose/nerdcommenter'           " code line/block commented
    Plugin 'octol/vim-cpp-enhanced-highlight'   " extra highlights for cpp
    " Plugin 'hdima/Python-Syntax'                " highlights for python
    Plugin 'python-mode/python-mode'
    Plugin 'Vimjas/vim-python-pep8-indent'      " nicer indent for multiple lines
    Plugin 'godlygeek/tabular'                  " for markdown files, couple with vim-markdown
    Plugin 'plasticboy/vim-markdown'
    Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
    Plugin 'octol/vim-cpp-enhanced-highlight'   " extra highlights for cpp
    Plugin 'Valloric/YouCompleteMe'             " all for completion
    Plugin 'rust-lang/rust.vim'                 " for rust
    Plugin 'fatih/vim-go'                       " go go go
    Plugin 'junegunn/fzf.vim'                   " fuzzy finder
    Plugin 'fisadev/vim-isort'                  " python import sorted
    "-------------------=== Code lint= ==-----------------------------
    Plugin 'w0rp/ale'                           " support all major programming language
    " Plugin 'python-mode/python-mode'          " still in alpha phase?
    "-------------------=== other plugins ===-----------------------------
    " Plugin 'derekwyatt/vim-fswitch'           " switch between *.h and *.cpp

    " local installation:
    " The 'pinned' option
    " -------------------
    " A flag that, when set to a value of 1, tells Vundle not to perform any
    " git operations on the plugin, while still adding the existing plugin
    " under the `bundles` directories to the |runtimepath|.
    Plugin 'xterm-color-table.vim', {'pinned': 1}

call vundle#end()            " required
filetype on
filetype plugin on
filetype plugin indent on    " required
" }}}
  
" #############################
"  Part-2: colorscheme && GUI  {{{
" #############################
" Note: syntax enable is needed
syntax enable
set background=dark
" colorscheme zenburn
colorscheme Tomorrow-Night
if has('gui_running')
    " no toolbar
    set guioptions=
    " set guifont=Lucida_Console:h9
    " colorscheme solarized
    " call togglebg#map("<F5>")
endif
" }}}

" #############################
"  Part-3:  Set vim            {{{
" #############################
" enable syntax highlight
syntax enable
" allow variable syntax highlight approches instead of the default
syntax on
" Highlight TODO, FIXME, NOTE, etc.
if has("autocmd")
    if v:version > 701
    autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
    endif
endif
hi Todo guifg=#0f4f4f guibg=#ffdfaf ctermfg=223 ctermbg=NONE gui=bold cterm=NONE
hi Debug guifg=#0f4f4f guibg=#ffdfaf ctermfg=223 ctermbg=NONE gui=bold cterm=NONE
" Do not use a mouse, otherwise :set mouse=n/v/i/a
set mouse=
" backspace for del
set backspace=indent,eol,start
" Split windows manners
set splitbelow
set splitright
" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase
" UI settings
set laststatus=2
set ruler
set cursorline
set cursorcolumn
set number relativenumber
set showcmd
set wildmenu
set showmatch
set noshowmode
" always keep cursor away 7 lines from the bottom
set scrolloff=7
set sidescrolloff=3
" do not wrap the code
set nowrap
" code fold
" press Space to toggle the current fold open/close;
" with fmd=manual, create a fold by visually selecting lines
set foldmethod=manual
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" do not fold when first startup vim
set nofoldenable
" History
set history=1024
set viminfo+=h  " do no store searches
" utf8 encoding
set encoding=utf-8
scriptencoding utf-8
" tab and space
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
" updatetime=4000(default)
set updatetime=1000
" markdown settings
set conceallevel=2
" }}}

" VimL example: vmpc.vim
set runtimepath+=$HOME/fggit/Practical_vim/square_motion/vmpc

" #############################
"  Part-4: <Leader> relative   {{{
" #############################
" leader set to be the comma
let mapleader=','
" quick source current vimscript
nnoremap <leader>s :source %<cr>
" quick save/exit etc
nnoremap <leader>w :w<cr>
nnoremap <space>w :Gwrite<cr>
nnoremap <space>c :Gcommit<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>
" shotcut to edit ~/_vimrc in new tab
nnoremap <leader>v :tabnew <bar> :e $MYVIMRC<cr>
nnoremap <space>v :sp $MYVIMRC<cr>
" common rule were: splitright & splitbelow
" but sometimes need to split on leftabove or above
" nnoremap <leader>lf :leftabove split
nnoremap <leader>up :above split
" yanking/pasting with system clipboard
" pasting from sys clipboard to vim
nmap <Space>p "+gp
" yank to sys clipboard only in Visual Mode
vnoremap <Space>y "+y
" shotcuts to new tabs and moving around
nnoremap <space>] :tabn<cr>
nnoremap <space>[ :tabp<cr>
" tmuxline snapshot file-saved
nnoremap <leader>tx :TmuxlineSnapshot! ~/.vim/colors/tx-airline<cr> :echo "***tx-snapshot saved***"<cr>
" The "e" flag tells ":substitute" that not finding a match is not an error.
" strip trailing whitespace (,,t)
nnoremap <leader><leader>t :%s/\s\+$//ge<cr>
" quick select buffer and delete it
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
" nnoremap <leader>bf :ls<cr>
" nnoremap <leader>bd :bd<cr>
" turn off highlights
nnoremap <space>n :nohlsearch<cr>
" windows/panes resize
nnoremap <silent> <Space>- :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Space>+ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Space>+ :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
" close quickfix/local window
nnoremap <space>q :lclose<cr>
nnoremap <space><space>q :cclose<cr>
" fzf shotcut
" imap <c-x><c-o> <plug>(fzf-complete-line)
map <space>b :Buffers<cr>
map <space>f :Files<cr>
map <space>g :GFiles<cr>
map <space>t :Tags<cr>
" Allows fzf to ignore patterns in .gitignore
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Advanced customization using autoload functions
" (expand word completing window)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '20%'})
"""
" vertical split help
nnoremap <Space>h :vert help 
" alternative way to back to normal mode
inoremap jk <ESC>
" record & play the series of commands
" Start recording keystrokes by typing qq.
" End recording with q (first press Escape if you are in insert mode).
" Play the recorded keystrokes by hitting space-q.
nnoremap <space>q @q
" groups of specific commands on specific machine
if hostname() == 'panyu202'
    " CC = change to directory of Current file
    command CC cd %:p:h <bar> :e %
    " Vgit = saveas % to someother dir
    command Vgit sav! ~/fggit/gitrepos/fmhGRs/dotfiles/.vimrc
endif

" groups of specific commands on specific machine, case insensitive compared
if hostname() ==? 'panyu202'
    " CC = change to directory of Current file
    command CC cd %:p:h <bar> :e %
    " Vgit = saveas % to someother dir
    command Vgit sav! ~/fggit/gitrepos/fmhGRs/dotfiles/.vimrc
endif

" groups of abbreviate
" insert the datetime
iab dts <c-r>=strftime("%a %d %b %Y %T")<cr>
" Thu 25 Feb 2021 21:25:42
" only for PPPCpp practicing
" iab stdlib #include "../std_lib_facilities.h"
" Emoji shortcuts
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
ab :thanks: 😜
ab :kiding: 🙄
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
" }}}

" #############################
" Part-5: plugin setting groups
" #############################

" Isort key-bind----------------- {{{
let g:vim_isort_map = '<C-i>'
" " Or disable the mapping with this:
" " let g:vim_isort_map = ''
" You can configure overrides for isort's config parameters:
" let g:vim_isort_config_overrides = {
"   \ 'include_trailing_comma': 1, 'multi_line_output': 3}
" so if isort is installed under Python 3:
let g:vim_isort_python_version = 'python3'
" }}}
" vim-ack & ag----------------- {{{
" do not auto-jump (ack!) to the first result
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap <leader>a :Ack!<Space>
command Todo Ack! 'TODO|FIXME|CHANGED|HACK'
command Debug Ack! 'NOTE|INFO|IDEA'
" }}}
" vim-go ---------------------- {{{
let g:go_list_type = 'locationlist'
let g:go_list_type_commands = {'GoBuild': "quickfix"}
" let g:go_list_autoclose = 1
" using terminal feature
let g:go_term_enabled = 1
" let g:go_term_mode = "vsplit"
let g:go_term_mode = 'split'
let g:go_term_height = 20
let g:go_fmt_autosave = 1
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_deadline = "5s"
let g:go_def_mapping_enabled = 1
let g:go_def_reuse_buffer = 1
let g:go_gopls_enabled = 1
let g:go_rename_command = 'gopls'
let g:go_fmt_command = 'goimports'
" let g:go_fmt_fail_silently = 1
" let g:go_addtags_transform = "camelcase"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_auto_type_info = 1
" let g:go_auto_sameids = 1
" }}}

" rust.vim -------------------- {{{
let g:rustfmt_autosave = 1
let g:ale_rust_cargo_use_check = 1
" let g:rust_cargo_check_all_targets = 1
" }}}

" tmuxline -------------------- {{{
let g:tmuxline_theme = 'zenburn'
let g:airline#extensions#tmuxline#enabled = 1
let g:tmuxline_powerline_separators = 0
" let g:tmuxline_preset = '' "see autoload/tmuxline/preset/*
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '\u2206t#(uptime | cut -d " " -f 4,5 | cut -d "," -f 1)',
      \'c'    : '#(tmux display-message -p "#{pane_current_path}" | sed "s#$HOME#~#g")',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'y'    : ['%R','%a', '%F' ],
      \'z'    : '#H'}
" }}}'#H' | '#(tmux display-message -p "#{pane_current_path}" | sed "s#$HOME#~#g")'

" ctags ----------------------- {{{
" look in the current directory for "tags",
" and work up the tree towards root until one is found.
set tags=./tags;/
" set tags=./tags;$HOME
" NOTE: already setup goto with YcmCompleter, seems this is overlap
" Wed 01 Jan 2020 18:45:52
" generate tag file, so we can Ctrl-] to goto definitions
" nnoremap <F9> :!ctags -R<cr>
" }}}

" fzf as vim-plugin ----------- {{{
" NOTE: deal with the rtp of fzf difference from other machine's
if hostname() == 'wuhan608'
    set rtp+=~/.fzf
elseif hostname() == 'panyu202' 
    set rtp+=~/fggit/GitHub_repos/fzf
endif
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
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
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Customize fzf colors to match your color scheme
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
" }}}

" vim gitgutter -------------- {{{
let g:gitgutter_signs = 1
let g:gitgutter_max_signs = 500
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
" let g:gitgutter_sign_removed_first_line = '^^'
" let g:gitgutter_sign_modified_removed = 'ww'
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
" }}}

" vim-asyncrun --------------- {{{
" open quickfix by 10 lines height after commands starts
let g:asyncrun_open = 10
" save current(1) or all(2) modified buffer(s) before executing
let g:asyncrun_save = 1
" trim empty line in quickfix
let g:asyncrun_trim = 1
" if encoding problems with Chinese
" let g:asyncrun_encs = 'gbk'
" }}}

" vim-instant_markdown ------- {{{
" let it be slow (real-time update seems not mystyle)
let g:instant_markdown_slow = 0
" let g:instant_markdown_slow = 1
" manual trigger the preview window
let g:instant_markdown_autostart = 0
" uses MathJax
let g:instant_markdown_mathjax = 1
" only if not want to load images, stylesheets etc.
let g:instant_markdown_allow_external_content = 1
" to allow scripts to run
let g:instant_markdown_allow_unsafe_content = 1
" new in ver0.2.0 and latter
" choose a custom port instead of default 8090
" let g:instant_markdown_port = 8888
" auto-scrolls to Where the cursor is positioned
let g:instant_markdown_autoscroll = 1
" choose a custom browser
" let g:instant_markdown_browser = "firefox --new-window"
" let's just keep it on local for now
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
" }}}

" vim-markdown --------------- {{{
" fold style
let g:vim_markdown_folding_style_pythonic = 1
" To prevent foldtext from being set
let g:vim_markdown_override_foldtext = 0
" set header folding level
let g:vim_markdown_folding_level = 6
" no default key mappings
" let g:vim_markdown_no_default_key_mapping = 1
" enable TOC windown auto-fit
let g:vim_markdown_toc_autofit = 1
" text emphasis resriction to single line
" let g:vim_markdown_emphasis_multiline = 0
" syntax concealing
" disable math conceal with LaTex math syntax enable
" let g:tex_conceal = ""
let g:vim_markdown_math = 1
" do not require .md extensions for Markdown links
let g:vim_markdown_no_extensions_in_markdown = 1
" how to open new files [tab, vsplit, hsplit, current]
let g:vim_markdown_edit_url_in = 'hsplit'
" go to next header
map ]] <Plug>Markdown_MoveToNextHeader
map [[ <Plug>Markdown_MoveToNextHeader
" }}}

" tabular
let g:tabular_loaded = 1

" python-syntax highlight
let python_highlight_all = 1

" py_PEP8 indent settings
let g:python_pep8_indent_multiline_string = 1
let g:python_pep8_indent_hang_closing = 1

" UltiSnips settings --------- {{{
" handle the conflit with YCM
let g:UltiSnipsExpandTrigger='<leader><tab>'
let g:UltiSnipsJumpForwardTrigger='<leader><tab>'
let g:UltiSnipsJumpBackwardTrigger='<leader><S-tab>'
" include self-define Snippets
let g:UltiSnipsSnippetDir='$HOME/.vim/bundle/ultisnips'
let g:UltiSnipsSnippetDirectories=['UltiSnips', "fggsnippets"]
" UltiSinpsUsePythonVersion
let g:UltiSinpsUsePythonVersion = 3
let g:UltiSnipsNoPythonWarning = 1
" }}}

" vim-tmux-navigator --------- {{{
" disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
" Write all buffers before navigating from vim to tmux pane
" value:1 -- :update (current buffer iff changed);
"       2 -- :wall (write all bufffer)
" let g:tmux_navigator_save_on_switch = 1
" }}}

" nerdcommenter -------------- {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_cpp = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" }}}

" cpp highlight -------------- {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
" disable user difined funcs highlight
let g:cpp_no_function_highlight = 1
" }}}

" vim-signature -------------- {{{
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
" }}}

" YCM settings --------------- {{{
let g:ycm_server_python_interpreter = '/usr/bin/python3'
" 补全功能在注释中有效
let g:ycm_complete_in_comments = 1
" 在注释和字符串中获取标识符
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" show the full function prototype and overload
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_indentifiers_with_syntax=1
" 选择补全选项的移动方向
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" 显示详细诊断信息
let g:ycm_key_detailed_diagnostics = '<space>k'
" This command tries to perform the "most sensible" GoTo operation it can.
nnoremap <leader>g :YcmCompleter GoTo<CR>
" Looks up the identifier under the cursor and populates with the quickfix list
nnoremap <leader>r :YcmCompleter GoToReferences<CR>
" Looks up the symbol under the cursor and jumps to its declaration.
" nnoremap <leader>d :YcmCompleter GoToDeclaration<CR>
" Looks up the symbol under the cursor and jumps to its definition.
nnoremap <leader>j :YcmCompleter GoToDefinition<CR>
" Displays the preview window populated with quick info about the identifier under the cursor.
nnoremap <leader>k :YcmCompleter GetDoc<CR>
" }}}

" EasyMotion ----------------- {{{
" disable default prefix <leader><leader>
let g:EasyMotion_do_mapping=0
" case insensitive on
let g:EasyMotion_smartcase=1
" find motions: line motions
map <leader>f <Plug>(easymotion-f)
map <leader>F <Plug>(easymotion-F)
" }}}

" tagbar settings ------------ {{{
let g:airline#extensions#tagbar#enabled = 1
let g:tagbar_autofocus=1
let g:tagbar_width=28
let g:tagbar_left=1
let g:tagbar_sort=0
let g:tagbar_show_linenumbers = 2     " show relative nu
let g:tagbar_expand = 1
" remap keys | toggle tagbar | Jump directly to tagbar
nnoremap <space><space>b :TagbarToggle<CR>
nnoremap <space>j :TagbarOpen fj<CR>
" }}}

" vim-indent-guides ---------- {{{
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
" leader + i to turn on/off the indent_guide
nmap <silent> <leader>> <Plug>IndentGuidesToggle
" }}}

" airline settings ----------- {{{
let g:airline#extensions#tabline = 1
let g:airline_theme='zenburn'
let g:airline_extensions=['branch', 'tagbar', 'ale', 'tabline' ]
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" airline symbols, install the fonts-powerline first
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" display the tail of the filename
let g:airline#extensions#tabline#formatter = 'unique_tail'
" configure symbol used to represent close button >
let g:airline#extensions#tabline#close_symbol = 'X'
" configure the title text for quickfix buffers >
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
" configure the title text for location list buffers >
let g:airline#extensions#quickfix#location_text = 'Location'

" vim-fugitive
let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#branch#empty_message = ''
" let g:airline#extensions#branch#vcs_priority = "git"
let g:airline#extensions#branch#displayed_head_limit = 10
" let g:airline#extensions#branch#format = 0

" vim-Obsession
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#obsession#indicator_text = '$'
" let g:airline_section_z = airline#section#create([
"                     \   '%{ObsessionStatus(''$'','''')}',
"                     \   'windowswap', '%3p%% ', 'linenr', ':%3v '])
" }}}

" ale settings --------------- {{{
let g:ale_enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = '0'
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \   'cpp': ['libclang', 'gcc', 'clangd'],
            \   'go': ['gobuild', 'govet', 'gofmt'],
            \   'c': ['clang', 'gcc'],
            \   'sh': ['shellcheck'],
            \   'vim': ['vint'],
            \   'rust': ['cargo', 'rustc'],
            \   'python': ['flake8']
            \}
" let g:ale_python_flake8_use_global = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_fixers = {
            \   'python': ['yapf', 'autopep8']
            \}
" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)
" shell scripts static syntax linter
let g:ale_sh_shellcheck_executable = 'shellcheck'
let g:ale_sh_shellcheck_dialect = 'auto'
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_echo_cursor = 1
let g:ale_open_list = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 0
" Show 10 lines of errors (default: 10)
let g:ale_list_window_size = 10
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" ale movements
nmap <silent> <C-p> <Plug>(ale_previous)
nmap <silent> <C-n> <Plug>(ale_next)
" }}}

" ----------------------------
" Part-6 autocmd groups
" ----------------------------
" highlight 'long' lines(>= 79 symbols) ------- {{{
augroup filefmt_autocmds
    au!
    au FileType python,sh,markdown,md,c,cpp,rust,rs,go,vim highlight Excess ctermbg=DarkGrey guibg=Black
    au FileType python,sh,markdown,md,c,cpp,rust,rs,go,vim match Excess /\%80v.*/
    au FileType python,sh,markdown,md,c,cpp,rust,rs,go,vim set nowrap
    au FileType python,sh,markdown,md,c,cpp,rust,rs,go,vim set colorcolumn=79
    " auto begin in newline when exceed 79 charust,rs when edit these filetypes
    au FileType python,sh,markdown,md,c,cpp,rust,rs,go,vim setlocal textwidth=79 formatoptions+=t
    " Don't add the comment prefix when I hit enter or o/O on a comment line
    au FileType python,sh,markdown,md,c,cpp,rust,rs,go,vim setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
" }}}

" augroup for edit *.gpg encrypted files
" Don't save backups of *.gpg files
set backupskip+=*.gpg
" To avoid that parts of the file is saved to .viminfo when yanking or deleting, empty the viminfo option
set viminfo=
" vim to edit the gpg encrypted file -------------------------------------- {{{
augroup filetype_gpg
    au!
    " Disable swap files, and set binary file format before reading the file
    au BufReadPre,FileReadPre *.gpg
        \ setlocal noswapfile bin
    " Decrypt the contents after reading the file, reset binary file format and run any BufReadPost
    " autocmds matching the file name without the .gpg extension
    au BufReadPost,FileReadPost *.gpg
        \ execute "'[,']!gpg --decrypt --default-recipient-self" |
        \ setlocal nobin |
        \ execute "doautocmd BufReadPost " . expand("%:r")
    " Set binary file format and encrypt the contents before writing the file
    au BufWritePre,FileWritePre *.gpg
        \ setlocal bin |
        \ '[,']!gpg --encrypt --default-recipient-self
    " After writing the file, do an :undo to revert the encryption in the buffer, and reset binary file format
    au BufWritePost,FileWritePost *.gpg
        \ silent u |
        \ setlocal nobin
augroup END
" }}}

" golang mappings ---------------------------- {{{
augroup golang
    au!
    au FileType go nmap <space>r <Plug>(go-run)
    au FileType go nmap <space>t <Plug>(go-test)
    au FileType go nmap <space>b  <Plug>(go-build)
    au FileType go nmap <leader>i <Plug>(go-info)
    au FileType go nmap <leader>g <Plug>(go-def-vertical)
    au FileType go nmap <leader>r <Plug>(go-rename)
    au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END
" }}}

" vim-emoji mappings ---------------------------- {{{
" " only one completefunc working at a time, have to make way for YCM
" set completefunc=emoji#complete
" " replace :emoji_name: into Emojis
" %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
" " emoji for gitgutter signs
" let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
" let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
" let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
" let g:gitgutter_sign_modified_removed = emoji#for('collision')
" }}}
" augroup vimemoji
"     au!
"     au FileType md,markdown set completefunc=emoji#complete
" augroup END
" }}}
" vimscript file settings -------------- {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
" }}}

" make change in vimrc working immediately
augroup autosrc
    au!
    au BufWritePost $MYVIMRC source $MYVIMRC
augroup END
