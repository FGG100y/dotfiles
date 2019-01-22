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
nnoremap <leader><leader>s :source ~/_vimrc<cr>
" shotcut for edit ~/_vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
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
noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Join lines by <leader>j becuase I usually forget turn to lower case
noremap <leader>j J
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
let g:solarized_termcolors=256
if has('gui_running')
	" set background=dark
	" setcolorscheme solarized
	" setcolorscheme molokai
	colorscheme phd
    au GUIEnter * simalt ~x
else
	colorscheme zenburn
	" setcolorscheme solarized
	" setcolorscheme molokai
endif
call togglebg#map("<F4>")  " change color scheme

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
" auto begin in newline when exceed 79 chars
autocmd FileType python setlocal textwidth=79 formatoptions+=t
" comment leader for different filetypes
autocmd FileType sh,python let b:comment_leader = '# '
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

" other plugins
" =============
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/phd'
Plugin 'SuperTab'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'kshenoy/vim-signature'
Plugin 'easymotion/vim-easymotion'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'itchyny/lightline.vim'
" Plugin 'python-mode/python-mode', { 'branch': 'develop' }
" Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'suan/vim-instant-markdown'
" Plugin 'derekwyatt/vim-fswitch'
call vundle#end()            " required
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
let g:UltiSnipsUsePythonVersion = 3
" let g:UltiSnipsSnippetDirectories=['My_snippets']
" make sure self-defined snippets samples is under '~/.vim/bundle/'
let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/'
let g:UltiSnipsExpandTrigger = "<leader><Tab>"
let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger = "<leader><Tab>"
let g:UltiSnipsJumpBackwardTrigger = '<leader><S-Tab>'

" ----------------------------
" airline settings
" ----------------------------
" let g:airline_theme='simple'
