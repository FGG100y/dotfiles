" ===================================
" fanmh's vimrc (Ubuntu Envs)
" builted: 2018-07-16
" update: Sat 22 Jun 2019 11:08:39
" ===================================
"

set nocompatible                                " be iMproved

" ALWAYS PUT PLUGINS FIRST PLACE
" TO ADVOID SOME SILLY MISTAKES.
" #############################
"  Part-I:  Plugins
" #############################
" ----------------------------
" " Vundle for plugins management
" ----------------------------
filetype off                                    " required

set rtp+=$HOME/.vim/bundle/Vundle.vim/          " set the runtime path to include Vundle and initialize
" set rtp+= ~/vimfiles/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path and call
" vundle#begin('~/some/path/here')
" NOTE: all the Plugins which is managed
" by Vundle must lie between
" vundle#begin() and vundle#end
    
    "-------------------=== Vundle itself ===-------------
    Plugin 'VundleVim/Vundle.vim'               " let Vundle manage Vundle, required

    "-------------------=== Code/Project navigation ===-------------
    " Plugin 'scrooloose/nerdtree'                " Project and file navigation
    Plugin 'scrooloose/nerdcommenter'           " code line/block commented
    Plugin 'majutsushi/tagbar'                  " Class/module browser
    Plugin 'kien/ctrlp.vim'                     " Fast transitions on project files
    Plugin 'nathanaelkane/vim-indent-guides'    " indent guides visulized
    Plugin 'Vimjas/vim-python-pep8-indent'      " nicer indent for multiple lines
    Plugin 'kshenoy/vim-signature'              " bookmark etc
    Plugin 'easymotion/vim-easymotion'

    "-------------------=== vim outfit ===-------------------------------
    Plugin 'vim-airline/vim-airline'            " Lean & mean status/tabline for vim
    Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
    Plugin 'Lokaltog/powerline'                 " Powerline fonts plugin
    Plugin 'flazz/vim-colorschemes'             " Colorschemes
    Plugin 'jnurmine/Zenburn'
    Plugin 'altercation/vim-colors-solarized'

    "-------------------=== tmux ===-------------------------------
    Plugin 'christoomey/vim-tmux-navigator'     " move to vim in tmux, it will take over and vice verse

    "-------------------=== Snippets support ===--------------------
    Plugin 'SirVer/ultisnips'                   " snippets management/engine
    Plugin 'honza/vim-snippets'                 " snippets repo

    "-------------------=== Languages support ===-------------------
    " Plugin 'tpope/vim-commentary'                 " Comment stuff out
    Plugin 'airblade/vim-gitgutter'             " shows a git diff in the sign column (i.e., gutter)
    Plugin 'tpope/vim-fugitive'                 " awsome git wrapper!
    Plugin 'tpope/vim-obsession'                " :mksession --> :Obsess || :source or vim -S back to session.vim
    Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
    Plugin 'tpope/vim-repeat'                   " enhance . repeat
    Plugin 'Valloric/YouCompleteMe'             " Autocomplete plugin
    Plugin 'octol/vim-cpp-enhanced-highlight'   " extra highlights for cpp
    Plugin 'hdima/Python-Syntax'                " highlights for python
    Plugin 'godlygeek/tabular'                  " for markdown files, couple with vim-markdown
    Plugin 'plasticboy/vim-markdown'
    " Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}

    "-------------------=== Code lint= ==-----------------------------
    Plugin 'w0rp/ale'
    " Plugin 'python-mode/python-mode'
    " Plugin 'scrooloose/syntastic'               " Syntax checking plugin for Vim

    " local installation using the ['file://'+'absolute path'] protocol

    " other plugins
    " =============
    " Plugin 'altercation/vim-colors-solarized'
    " Plugin 'suan/vim-instant-markdown'
    " Plugin 'derekwyatt/vim-fswitch'           " switch between *.h and *.cpp
call vundle#end()            " required
filetype on
filetype plugin on
filetype plugin indent on    " required



" #############################
"  Part-II: <Leader> relative
" #############################
let mapleader=","		" leader set to be the comma
" -----------------------------------
" groups of <leader> + ?  | Short Cut
" -----------------------------------

" source vimrc && echo 'reloaded'
nnoremap <silent> <leader><leader>s :source ~/.vimrc<CR>:echo '-*- vimrc reloaded -*-'<CR>
" shotcut to edit ~/_vimrc
nnoremap <leader>ev :vs ~/.vimrc<cr>
" quick save/exit etc
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader><S-q> :q!<cr>
" vertical split help
nnoremap <leader>vh :vert help<cr>

" yanking/pasting with system clipboard
" pasting from sys clipboard to vim
nmap <leader>p "+gp  
" yank to sys clipboard only in Visual Mode
vnoremap <leader>y "+y  


" shotcuts to new tabs and moving around
nnoremap <leader>tn :tabn<cr>
nnoremap <leader>tp :tabp<cr>
nnoremap <leader>te :tabnew<cr>
nnoremap <leader>to :tabonly<cr>

" quick select buffer and delete it
" nnoremap <leader>bn :bnext<cr>
" nnoremap <leader>bp :bprevious<cr>
" nnoremap <leader>bf :ls<cr>
" nnoremap <leader>bd :bd<cr>

" turn off highlights
nnoremap <leader><space> :nohlsearch<cr>


" windows/panes resize
nnoremap <space>w :vertical resize +7<cr>
nnoremap <S-w> :resize +5<cr>

" self-define whitespace.vim for *.py
" nnoremap <leader><space> :call whitespace#strip_trailing()<CR>

" Or using a function in vimrc directly
" strip trailing whitespace (,ss)
" augroup whitespace
"     autocmd!
"     function! StripWhitespace ()
"         let save_cursor = getpos(".")
"         let old_query = getreg('/')
"         :%s/\s\+$//e
"         call setpos('.', save_cursor)
"         call setreg('/', old_query)
"     endfunction
"     noremap <leader>ss :call StripWhitespace()<cr>
" augroup END

" close quickfix window (,,q)
map <leader><leader>q :cclose<cr>

" insert the datetime
iab dts <c-r>=strftime("%a %d %b %Y %T")<cr>


"" If buffer modified, update any 'Last modified: ' in the first 20 lines.
"" 'Last modified: ' can have up to 10 characters before (they are retained).
"" Restores cursor and window position using save_cursor variable.
" function! LastModified()
"   if &modified
"     let save_cursor = getpos(".")
"     let n = min([20, line("$")])
"     keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
"           \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
"     call histdel('search', -1)
"     call setpos('.', save_cursor)
"   endif
" endfun
" autocmd BufWritePre * call LastModified()
" ==== Leader settings end =============
"
"
" #############################
"  Part-III:  Set vim
" #############################
" enable syntax highlight
syntax enable
" allow variable syntax highlight approches instead of the default
syntax on
" Do not use a mouse, otherwise :set mouse=n/v/i/a
set mouse=
" backspace for del
set backspace=indent,eol,start
" Split windows manners
set splitbelow
set splitright
" Ctrl + j,k,l,h to move around the panes
" Conflit with tmux-navigator's hotkey, Sun 31 Mar 2019 10:30:04)
" nnoremap <C-j> <C-W><C-J>
" nnoremap <C-k> <C-W><C-K>
" nnoremap <C-l> <C-W><C-L>
" nnoremap <C-h> <C-W><C-H>
" " Searching
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
" always keep cursor away 5 lines from the bottom
set scrolloff=7
set sidescrolloff=3
" do not wrap the code
set nowrap
" code fold
set foldmethod=syntax
" do not fold when first startup vim
set nofoldenable

" History
set history=1024
set viminfo+=h  " do no store searches

" py_PEP8
set encoding=utf-8
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

" #############################
"  Part-IV: colorscheme && GUI
" #############################
" gui appearance && colorschemes
" Note: syntax enable is needed
syntax on
syntax enable
" set background=dark
" set background=light
if has('gui_running')
    " GUI setting, no toolbar
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
    " GUI colorscheme, font, screensize, etc
    " colorscheme solarized
    " let g:solarized_termcolors=256
    " let g:solarized_contrast="normal"
    " call togglebg#map("<F5>")
    colorscheme zenburn                       " backup colorscheme
    " set guifont=Lucida_Console:h9            " some other fonts
    " au GUIEnter * simalt ~x                   " full screen when initiate gvim
else
    " colorscheme zenburn
    colorscheme solarized
    " let g:solarized_termcolors=256
    let g:solarized_contrast="normal"
    call togglebg#map("<F5>")
endif


" #############################
" Part-V: plugin setting groups
" #############################
" ----------------------------
" vim-instant-markdown
" ----------------------------
" Uncomment to override defaults
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1 
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1

" ----------------------------
" python-syntax highlight
" ----------------------------
let python_highlight_all = 1

" ----------------------------
" py_PEP8 indent settings
" ----------------------------
let g:python_pep8_indent_multiline_string = 1
let g:python_pep8_indent_hang_closing = 1

" ----------------------------
" UltiSnips settings
" ----------------------------
" handle the conflit with YCM
"   g:UltiSnipsExpandTrigger               <tab>
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><S-tab>"
" include self-define Snippets
" let g:UltiSnipsSnippetDirectories=[]
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
" let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" UltiSinpsUsePythonVersion
let g:UltiSinpsUsePythonVersion = 3
let g:UltiSnipsNoPythonWarning = 1

" ----------------------------
" vim-tmux-navigator settings
" ----------------------------
" disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
" Write all buffers before navigating from vim to tmux pane
" value:1 -- :update (current buffer iff changed);
"       2 -- :wall (write all bufffer)
" let g:tmux_navigator_save_on_switch = 1

" ----------------------------
" nerdcommenter settings
" ----------------------------
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

" ----------------------------
" cpp highlight settings
" ----------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
" disable user difined funcs highlight
let g:cpp_no_function_highlight = 1

" ----------------------------
" vim-signature settings
" ----------------------------
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

" ----------------------------
" YCM settings
" ----------------------------
" Fri 05 Apr 2019 15:23:53 didn't understand following lines' meaning
" let g:ycm_python_interpreter_path = ''
" let g:ycm_python_sys_path = []
" let g:ycm_extra_conf_vim_data = [
"   \  'g:ycm_python_interpreter_path',
"   \  'g:ycm_python_sys_path'
"   \]
" let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'

" set the ycm_server to python2, and it will be fine
" it will not complain about 'ycm server shutdown blabla...'
let g:ycm_server_python_interpreter = 'python2'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" 允许vim加载.ycm_confirm_extra_conf.py文件，不再提示
let g:ycm_confirm_extra_conf=0
" 补全功能在注释中有效
let g:ycm_complete_in_comments=1
" 设置OmniCppComplete补全引擎的快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口出现，只显示补全列表
set completeopt-=preview
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_indentifiers_with_syntax=1
" 引入 C++ 标准库tags
" set tags+=/data/misc/software/misc./vim/stdcpp.tags
" 从下往上选择补全选项
" let g:ycm_key_list_select_completion = ['<TAB>', '<Up>']

" ----------------------------
" EasyMotion settings
" ----------------------------
let g:EasyMotion_do_mapping=0  " disable default prefix <leader><leader>
let g:EasyMotion_smartcase=1   " case insensitive on
" find motions: line motions
map <leader>f <Plug>(easymotion-f)
map <leader>F <Plug>(easymotion-F)


" ----------------------------
" tagbar settings
" ----------------------------
let g:airline#extensions#tagbar#enabled = 1
let g:tagbar_autofocus=1
let g:tagbar_width=28
let g:tagbar_left=1
let g:tagbar_sort=0
let g:tagbar_show_linenumbers = 2     " show relative nu
let g:tagbar_expand = 1
" remap keys
nnoremap <F9> :TagbarToggle<CR>
" autocmd BufEnter *.py :call tagbar#autoopen(0)
" autocmd BufWinLeave *.py :TagbarClose

" ----------------------------
" ctrlp settings
" ----------------------------
let g:ctrlp_map='<C-p>'            " Invoke the Ctrlp in Normal mode
let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_by_filename = 1        " <C-d> toggle on/off inside
let g:ctrlp_max_files = 10000

" MRU mode options:~
let g:ctrlp_mruf_max = 250
" let g:ctrlp_mruf_include = '\.py$\|\.sh$|\.cpp$|\.c$'
let g:ctrlp_mruf_save_on_update = 1
" Set this to 1 to show only MRU files in the current working directory:
let g:ctrlp_mruf_relative = 0
let g:ctrlp_mruf_case_sensitive = 1           " Avoid duplicate MRU entries
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'

" remap commands && kb shortcuts
" only to find the buffers
nnoremap <leader>b :CtrlPBuffer<CR>
" only to find Most-Reccently-Used files
nnoremap <leader>m :CtrlPMRU<cr>

" Ctrlp Opening/Creating a file:~
"   <cr>
"     Open the selected file in the 'current' window if possible.
"   <c-t>
"     Open the selected file in a new 'tab'.
"   <c-v>
"     Open the selected file in a 'vertical' split.
"   <c-x>,
"   <c-cr>,
"   <c-s>
"     Open the selected file in a 'horizontal' split.
"   <c-y>
"     Create a new file and its parent directories.

" E - jump when <cr> is press, to window anywhere
" e - jump when <cr> is press, but only to window in the current tab
" t - jump when <c-t> is press, but only to window in the another tab
let g:ctrlp_switch_buffer = 'Et'

" Where to put the new tab page when opening one: >
" a - after; c - current tab;
let g:ctrlp_tabpage_position = 'ac'

" Use this option to specify how the newly created file is to be opened when
" pressing <c-y>: >
let g:ctrlp_open_new_file = 'v'

" Customized the line highlight color in ctrlp
" let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit': 'BrightHighlightOff', }

" function BrightHighlightOn()
"   " hi CursorLine cterm=NONE ctermbg=darkgrey guibg=darkred guifg=white ctermfg=None
"   hi CursorLine guibg=darkred
" endfunction
"
" function BrightHighlightOff()
"   hi CursorLine guibg=#191919
"   " hi CursorLine guibg='default'
" endfunction

" ----------------------------
" vim-indent-guides settings
" ----------------------------
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
" leader + i to turn on/off the indent_guide
nmap <silent> <leader>> <Plug>IndentGuidesToggle

" ----------------------------
" airline settings
" ----------------------------
let g:airline#extensions#tabline = 1
let g:airline_theme='simple'
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
" set marked window indicator string >
" let g:airline#extensions#obsession#indicator_text = '$'
let g:airline_section_z = airline#section#create([
                    \   '%{ObsessionStatus(''$'','''')}',
                    \   'windowswap', '%3p%% ', 'linenr', ':%3v '])

" ----------------------------
" ale settings
" ----------------------------
let g:ale_enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

let g:ale_linters_explicit = 1
let g:ale_linters = {
            \   'cpp': ['clang', 'clangd'],
            \   'c': ['clang', 'gcc'],
            \   'sh': ['shellcheck'],
            \   'python': ['flake8','pylint', 'pycodestyle']
            \}
let g:ale_python_pyflakes_executable = 1
let g:ale_python_pyflakes_use_global = 1

let g:ale_fixers = {
            \   'python': ['autopep8', 'trim_whitespace', 'yapf']
            \}

" shell scripts static syntax linter
let g:ale_sh_shellcheck_executable = 'shellcheck'
let g:ale_sh_shellcheck_dialect = 'auto'

let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_echo_cursor = 1

let g:ale_open_list = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 0
" Show 10 lines of errors (default: 10)
let g:ale_list_window_size = 10

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" this is conflit with CtrlP
" nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)


" " ----------------------------
" " python-mode settings
" " ----------------------------
" let g:pymode = 0
" syntax highlight
" let g:pymode_syntax=0
" let g:pymode_syntax_slow_sync=1
" let g:pymode_syntax_all=1
" let g:pymode_syntax_print_as_function=g:pymode_syntax_all
" let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
" let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
" let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
" let g:pymode_syntax_highlight_self=g:pymode_syntax_all
" let g:pymode_syntax_indent_errors=g:pymode_syntax_all
" let g:pymode_syntax_string_formatting=g:pymode_syntax_all
" let g:pymode_syntax_space_errors=g:pymode_syntax_all
" let g:pymode_syntax_string_format=g:pymode_syntax_all
" let g:pymode_syntax_string_templates=g:pymode_syntax_all
" let g:pymode_syntax_doctests=g:pymode_syntax_all
" let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
" let g:pymode_syntax_builtin_types=g:pymode_syntax_all
" let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
" let g:pymode_syntax_docstrings=g:pymode_syntax_all
                                  
" ----------------------------   
" Syntastic settings             
" NOTE: this plugin is similar
" with the pymode. I cannot
" tell the difference between
" their performent. Jan-25, 19
" Fri 05 Apr 2019 16:01:16 And already has ALE
" ----------------------------
" 
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_loc_list=1
" let g:syntastic_enable_signs=1
" let g:syntastic_check_on_wq=1
" let g:syntastic_aggregate_errors=1
" let g:syntastic_loc_list_height=10
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_error_symbol=">>"
" let g:syntastic_style_error_symbol="S>"
" let g:syntastic_warning_symbol="->"
" let g:syntastic_style_warning_symbol="->"
" let g:syntastic_python_checkers=['pyflakes', 'pydocstyle', 'python']


" ----------------------------   
" autocmd groups
" ----------------------------
" highlight 'long' lines (>= 79 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,sh,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,sh,c,cpp match Excess /\%80v.*/
    autocmd FileType python,sh,c,cpp set nowrap
    autocmd FileType python,sh,c,cpp set colorcolumn=79
    " auto begin in newline when exceed 79 chars when edit these filetypes
    autocmd FileType python,sh,c,cpp setlocal textwidth=79 formatoptions+=t
    " Don't add the comment prefix when I hit enter or o/O on a comment line
    autocmd FileType python,sh,c,cpp setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " make change in vimrc working immediately
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
