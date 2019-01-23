" ===================================
" fanmh's vimrc (Ubuntu Evns)
" lastest update: 2019-01-22
" ===================================
"
" #############################
"  Part-I: <Leader> relative
" #############################
let mapleader=","		" leader set to be the comma
" -----------------------------------
" groups of <leader> + ?  | Short Cut
" -----------------------------------
" shotcut for source ~/_vimrc
nnoremap <leader><leader>s :source ~/.vimrc<cr>
" shotcut for vertical split help
nnoremap <leader>vh :vert help<cr>
" quick save/exit etc
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>

" yanking/pasting with system clipboard
" pasting from sys clipboard to vim
nmap <leader>v "+gp  
" yank to sys clipboard only in Visual Mode
vnoremap <leader>c "+y  

" shotcuts to new tabs and moving around
nnoremap <leader>] :tabn<cr>
nnoremap <leader>[ :tabp<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove<cr>
nnoremap <leader>tl :tablast<cr>
" opens a new tab with the current buffer's path
" map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>

" buffers relatives
" close the current buffer
nnoremap <leader>bd :bclose<cr>:tabclose<cr>gT
" quick select buffer
nnoremap <leader>bl :bnext<cr>
nnoremap <leader>bh :bprevious<cr>
" split horizonal panes & navigations
nnoremap <leader>- :sv<cr>
" Ctrl + j,k,l,h to move around the panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" turn off highlights
nnoremap <leader><space> :nohlsearch<CR>

" Commenting blocks of code, e.g., sh, python
nnoremap <silent> <Leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
nnoremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Join lines by <leader>j becuase I usually forget turn to lower case
nnoremap <leader>j J
" ==== Leader settings end =============
"
"
" #############################
"  Part-II:  Set vim
" #############################

set nocompatible              " be improved, also required for Vundle

" enable syntax highlight
syntax enable
" allow variable syntax highlight approches instead of the default
syntax on
" filetype detecte
filetype on
filetype indent on
" GUI setting
" let g:solarized_termcolors=256
if has('gui_running')
	" set background=dark
	colorscheme solarized
    call togglebg#map("<F4>")  " change colorscheme'bg
	" colorscheme molokai
	" colorscheme phd
    au GUIEnter * simalt ~x
endif
set background=dark
" colorscheme solarized
" call togglebg#map("<F4>")  " change colorscheme'bg
colorscheme zenburn
" colorscheme molokai

" gui no toolbar
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b

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
set noruler
set cursorline
set cursorcolumn
set number relativenumber
set cursorline
set showcmd
set wildmenu
set showmatch
set noshowmode
set laststatus=2
" always keep cursor away 3 lines from the bottom
set scrolloff=3
set sidescroll=3
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
"  Part-III:  autocmd groups
" #############################
"
" #############################
"  Part-IV:  Plugins
" #############################
" ----------------------------
" " Vundle for plugins
" ----------------------------
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim/  " ~/vimfiles/bundle/Vundle.vim
call vundle#begin()  " '$HOME/.vim/bundle/'
    " alternatively, pass a path where Vundle should install plugins
    " call vundle#begin('~/some/path/here')
    " NOTE : all the Plugins which is managed by Vundle must lie between
    " vundle#begin() and vundle#end
    
    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    "-------------------=== Code/Project navigation ===-------------
    " Plugin 'scrooloose/nerdtree'                " Project and file navigation
    Plugin 'majutsushi/tagbar'                  " Class/module browser
    Plugin 'kien/ctrlp.vim'                     " Fast transitions on project files
    Plugin 'nathanaelkane/vim-indent-guides'    " indent guides visulized
    Plugin 'kshenoy/vim-signature'              " bookmark etc
    Plugin 'easymotion/vim-easymotion'

    "-------------------=== Other ===-------------------------------
    Plugin 'vim-airline/vim-airline'            " Lean & mean status/tabline for vim
    Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
    Plugin 'Lokaltog/powerline'                 " Powerline fonts plugin
    Plugin 'fisadev/FixedTaskList.vim'          " Pending tasks list
    Plugin 'rosenfeld/conque-term'              " Consoles as buffers
    Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
    Plugin 'flazz/vim-colorschemes'             " Colorschemes

    "-------------------=== Snippets support ===--------------------
    Plugin 'garbas/vim-snipmate'                " Snippets manager
    Plugin 'MarcWeber/vim-addon-mw-utils'       " dependencies #1
    Plugin 'tomtom/tlib_vim'                    " dependencies #2
    Plugin 'honza/vim-snippets'                 " snippets repo

    "-------------------=== Languages support ===-------------------
    Plugin 'SuperTab'
    Plugin 'tpope/vim-commentary'               " Comment stuff out
    Plugin 'tpope/vim-fugitive'
    " Plugin 'mitsuhiko/vim-sparkup'              " Sparkup(XML/jinja/htlm-django/etc.) support
    " Plugin 'Rykka/riv.vim'                      " ReStructuredText plugin
    " Plugin 'Valloric/YouCompleteMe'             " Autocomplete plugin

    "-------------------=== Python  ===-----------------------------
    Plugin 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
    Plugin 'scrooloose/syntastic'               " Syntax checking plugin for Vim

    " other plugins
    " =============
    " Plugin 'jnurmine/Zenburn'
    " Plugin 'altercation/vim-colors-solarized'
    " Plugin 'w0rp/ale'
    " Plugin 'itchyny/lightline.vim'
    " Plugin 'octol/vim-cpp-enhanced-highlight'
    " Plugin 'suan/vim-instant-markdown'
    " Plugin 'derekwyatt/vim-fswitch'
call vundle#end()            " required
filetype on
filetype plugin on
filetype plugin indent on    " required


" ----------------------------
" EasyMotion settings
" ----------------------------
let g:EasyMotion_do_mapping=0  " disable default prefix <leader><leader>
let g:EasyMotion_smartcase=1   " case insensitive on
" find motions: line motions
map <leader>f <Plug>(easymotion-f)
map <leader>F <Plug>(easymotion-F)

" ----------------------------
" vim-indent-guides settings
" ----------------------------
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
" leader + i to turn on/off the indent_guide
nmap <silent> <leader>i <Plug>IndentGuidesToggle
" ----------------------------
" UltiSnips settings
" ----------------------------
" let g:UltiSnipsUsePythonVersion = 3
" let g:UltiSnipsSnippetDirectories=['My_snippets']
" make sure self-defined snippets samples is under '~/.vim/bundle/'
" let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/'
" let g:UltiSnipsExpandTrigger = "<leader><Tab>"
" let g:UltiSnipsListSnippets = '<C-Tab>'
" let g:UltiSnipsJumpForwardTrigger = "<leader><Tab>"
" let g:UltiSnipsJumpBackwardTrigger = '<leader><S-Tab>'

" ----------------------------
" airline settings
" ----------------------------
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

" ----------------------------
" tagbar settings
" ----------------------------
let g:tagbar_autofocus=0
let g:tagbar_width=42
autocmd BufEnter *.py :call tagbar#autoopen(0)
autocmd BufWinLeave *.py :TagbarClose

" ----------------------------
" snipmate settings
" ----------------------------
let g:snippets_dir='~/.vim/bundle/vim-snippets/snippets'

" ----------------------------
" python settings
" ----------------------------
" python executables for different plugins
let g:pymode_python='python'
let g:syntastic_python_python_exec='python'

" rope
let g:pymode_rope=0
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
let g:pymode_rope_auto_project=0
let g:pymode_rope_enable_autoimport=0
let g:pymode_rope_autoimport_generate=0
let g:pymode_rope_guess_project=0

" documentation
let g:pymode_doc=0
let g:pymode_doc_bind='K'

" lints
let g:pymode_lint=0

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

" highlight 'long' lines (>= 79 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%80v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=79
    " auto begin in newline when exceed 79 chars
    autocmd FileType python setlocal textwidth=79 formatoptions+=t
    " comment leader for different filetypes
    autocmd FileType sh,python let b:comment_leader = '# '
augroup END

" code folding
let g:pymode_folding=0

" pep8 indents
let g:pymode_indent=1

" code running
let g:pymode_run=1
let g:pymode_run_bind='<leader>r'

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='X'
let g:syntastic_style_error_symbol='X'
let g:syntastic_warning_symbol='x'
let g:syntastic_style_warning_symbol='x'
let g:syntastic_python_checkers=['flake8', 'pydocstyle', 'python']
