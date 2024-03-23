" " This version of vimrc: using vim built-in pack for plugin management
" " Last-update: 2023-12-19 23:20 二

set nocompatible 		" a warn greeting to 21st cent.

" language en_US.utf8     " list here as a backup (not needed here, See .bashrc)

" " ================================Part-1: Colorscheme===== {{{
" " colorscheme when init with vimdiff (if alread in diffmode: colo zenburn)
if &diff
        colorscheme zenburn
endif
" " colorscheme and cursorline/cursorcolumn style
let current_scheme = get(g:, 'colors_name', 'default')
if 'default' == current_scheme
    " set bg=dark based on clock: (from help of Mixtral8x7b :)
    let &background = strftime("%H") < 8 || strftime("%H") > 18 ? "dark" : "light"
    set nocursorcolumn
    set cursorline
    hi CursorLine term=bold cterm=bold guibg=Grey40
endif
" nnoremap <F8> :set number! relativenumber!<CR>
" " do not highlight concealing part
nnoremap <F8> :hi Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE<CR>
" " }}}
" " ================================Part-2: Highlight tags===== {{{
" " enable filetype plugin detection etc, such as:
" " allow variable syntax highlight approches instead of the default
syntax on
filetype plugin on
filetype plugin indent on
" " Highlight TODO, FIXME, NOTE, etc. (must lie below `syntax on`)
" " more here: https://stackoverflow.com/questions/6577579/task-tags-in-vim
if has("autocmd")
    if v:version > 701
    autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|REFACTOR\|DEBUG\)')
    autocmd Syntax * call matchadd('Info', '\W\zs\(NOTE\|IDEA\|HACK\|STEP\|PART\)')
    endif
endif
hi Todo guifg=#0f4f4f guibg=#ffdfaf ctermfg=208 ctermbg=NONE gui=bold cterm=NONE
hi Info guifg=#0f4f4f guibg=#ffdfaf ctermfg=208 ctermbg=NONE gui=bold cterm=NONE
" " }}}
" " ================================Part-3: Settings=========== {{{
" " term_256color, better visualization
set t_Co=256
" " using fzf
set rtp+=~/.fzf
" " Do not need a mouse, otherwise :set mouse=n/v/i/a
set mouse=
" " backspace for delete (think windows)
"set backspace=indent,eol,start
" " Split windows manners
" set splitbelow
" set splitright
" " Searching
set incsearch
set hlsearch
set ignorecase
set smartcase
" " UI settings
set laststatus=2
set ruler
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
set foldmethod=manual
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
set updatetime=500
" " markdown concealed text hidden
set conceallevel=2
if !has('nvim')
    " " nnoremap <space>p "+gp : when the "+gp is not working, toggle the paste mode:
    " " then change to insert mode to paste the code,
    " " after pasting is done, toggle it back (to support 'auto-indent' again)
    set pastetoggle=<F2>
    " " no codeAI in lower verion
    if !has('patch-9.0.0185')
        let g:codeium_enabled = v:false
    endif
else
    " " this is for neovim, which report E519: Option not supported: pastetoggle
    nmap <F2> :set paste<cr>
    nmap <F3> :set nopaste<cr>
    " " try AI in nvim
    let g:codeium_enabled = v:true
endif
" " }}}
" " ================================Part-4: Leader Commands==== {{{
" " leader set to the comma, but the <space> also very helpful
let mapleader=","

" " Not so grace shotcuts to toggle themes dark/bright 
nnoremap <leader>tt :colo Tomorrow<cr>
nnoremap <leader>tn :colo Tomorrow-Night<cr>
" " quick save/exit etc
nnoremap <space>c :G commit -v<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>
" " ---------------------------------------------------------
" " shotcut to edit ~/_vimrc, and update it to local git repo
nnoremap <leader>v :tabnew <bar> :e ~/.vimrc<cr>
nnoremap <space>v :sp $MYVIMRC<cr>
" ---------------------------------------------------------
" " common rule were: splitright & splitbelow
" " but sometimes need to split on leftabove or above
" nnoremap <leader>lf :leftabove split
nnoremap <leader>up :above split
" yanking/pasting with system clipboard
" pasting from sys clipboard to vim
nnoremap <space>p "+gp
" " yank to sys clipboard only in Visual Mode
vnoremap <space>y "+y
" " shotcuts to new tabs and moving around
" " NOTE that 'Ctrl-w T' move the current pane to newtab
" " NOTE that 'Ctrl-w R' swap the splits top/bottom or left/right
nnoremap <space>] :tabn<cr>
nnoremap <space>[ :tabp<cr>
" " Ctrl-h/j/k/l to jump around
" " got the tmux-vim-nevigator, need not config here
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>
" tmuxline snapshot file-saved
nnoremap <leader>tx :TmuxlineSnapshot! ~/.vim/colors/tx-airline<cr> :echo "***tx-snapshot saved***"<cr>
" The "e" flag tells ":substitute" that not finding a match is not an error.
" strip trailing whitespace (,,t)
nnoremap <leader><leader>t :%s/\s\+$//ge<cr>
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
map <space>f :Gcd <bar> Files<cr>
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
" " insert pwd string
inoremap \fp <C-R>=getcwd()<CR>
" " groups of abbreviate
" " insert the datetime
" " insert mode by typing 'dts' >> 'Sat 28 Aug 2021 09:45:56'
" iab dts <c-r>=strftime("%a %d %b %Y %T")<cr>
iab dte <c-r>=strftime("%Y-%m-%d %H:%M %a")<cr>
iab dts <c-r>=strftime("%Y-%m-%d %a")<cr>
" " Em dash symbol
iab emdash —
" " Emoji shortcuts
" https://www.piliapp.com/symbol/arrow/
ab :lrarrow: ⮂
ab :lrarrow2: ⬌
ab :lrarrow3: ⇋
ab :rarrow: ⭢
ab :larrow: ⭠
ab :uarrow: ⭡
ab :darrow: ⭣
ab :branch: 
ab :bug: 🐞
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
" " ================================Part-5: Plugin Config====== {{{
" " codeium & nvim python --------------- {{{
" " wolk-around the Unknown highlight group name 'CodeiumSuggestion'
hi default CodeiumSuggestion guifg=#50FA7B ctermfg=Gray
" " Manually trigger suggestion | codeium#Complete() | <alt-Bslash>
let g:codeium_manual = v:true
" " disable for particular filetypes
let g:codeium_filetypes = {
    \ "bash": v:true,
    \ "python": v:true,
    \ "markdown": v:false,
    \ }
" " customize keymaps (examples):
" imap <script><silent><nowait><expr> <C-g> codeium#Accept()
" imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
" imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
" imap <C-x>   <Cmd>call codeium#Clear()<CR>
" " }}}
" " vim-jedi --------------- {{{                                                                                                                                                                                                    
" " user preference:
let g:jedi#popup_select_first = "1"
" " I myself prefer splits (Options: top, left, right, bottom or winwidth)
let g:jedi#use_splits_not_buffers = "winwidth"
" " lead jedi to the virtualenv of project
let g:jedi#environment_path = "auto"
" let g:jedi#environment_path = ".venv"
" " displays function call signatures; 0-disable,1-popup,2-cml
" let g:jedi#show_call_signatures = "1"
" let g:jedi#show_call_signatures = "2"
" " transparent jedi#show_call_signatures bg/fg color
hi Function ctermbg=none ctermfg=blue
hi jediFat ctermbg=none ctermfg=DarkRed
hi jediFunction ctermbg=none ctermfg=LightRed
" " }}}
" " vim easy align --------------- {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" " }}}
" " vim snip --------------- {{{
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsListSnippets="<c-tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" " }}}
" " vim-easymotion --------------- {{{                                                                                                                                                                                                    
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1  " Turn on case-insensitive feature

" " <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)

" " Need one more keystroke, but on average, it may be more comfortable.
" " s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" " JK motions: Line motions (relative linenum is good-enough)
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
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
" " Disabling conceal for code fences requires an additional setting:
" let g:vim_markdown_conceal_code_blocks = 0
" " do not require .md extensions for Markdown links '[link text](link-url)'
" " using the 'ge' command to open link-url.md instead of the file link-url
let g:vim_markdown_no_extensions_in_markdown = 1                                                                                                                                                                                        
" " how to open new files [tab, vsplit, hsplit, current]                                                                                                                                                                                
let g:vim_markdown_edit_url_in = 'hsplit'                                                                                                                                                                                               
" " go to next header                                                                                                                                                                                                                   
map ]] <Plug>Markdown_MoveToNextHeader                                                                                                                                                                                                  
map [[ <Plug>Markdown_MoveToNextHeader                                                                                                                                                                                                  
" " }}}
" " netrw gitignore ------------- {{{
let g:netrw_liststyle = 0
let g:netrw_list_hide= netrw_gitignore#Hide()
"let g:netrw_list_hide= netrw_gitignore#Hide('my_gitignore_file')
" " }}}
" " tagbar toggle---------------- {{{
let g:tagbar_sort = 0
let g:tagbar_width = 28
let g:tagbar_autofocus = 1
let g:tagbar_position = 'topleft vertical'
let g:tagbar_ctags_bin = "/home/ds01/ctags/uctags-2023.04.16-linux-x86_64/bin/ctags"
nnoremap <silent> <leader>b :TagbarToggle<cr>
nnoremap <space>j :TagbarOpen fj<cr>
" " }}}
" " Ack key-bind----------------- {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" " do not auto-jump to the first result using `Ack!`
" " 'Gcd' to go back to root-dir(where .git lives) first, for better project-wise searching
" " NOTE that 'Gcd' is Fugitive's command ; more info: https://github.com/mileszs/ack.vim/issues/188
:cnoreabbrev Ack Gcd <bar> Ack!
nnoremap <leader>a :Ack
command Todo Ack 'TODO|FIXME|CHANGED|HACK'
command Info Ack 'NOTE|INFO|IDEA|DEBUGGING'
" " }}}  
" " ALE ---- {{{
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
" let g:ale_sign_error = '☒'
let g:ale_sign_warning = '⚠'
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%-%code%] %s'
let g:ale_set_highlights = 1
" let g:ale_floating_window_border = repeat([''], 8)
" " Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
" " pylint too noisy
"    \   'python': ['flake8', 'pylint'],
let g:ale_linters = {
    \   'python': ['flake8'],
    \}
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
" let g:ale_python_flake8_use_global = 1
"            \   'python': ['yapf', 'autopep8'],
let g:ale_fixers = {
            \   'python': ['black', 'isort'],
            \   'sql': ['pgformatter'],
            \}
" " Bind F9 to fixing problems with ALE
nmap <F9> <Plug>(ale_fix)
" " Black --line-length=88, I prefer 79
" let g:ale_python_black_options='--line-length=79'
" " }}}
" " GITGUTTER ---- {{{
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
let g:gitgutter_preview_win_floating = 1
" " }}}
" " Hands on STATUSLINE ---- {{{
" " statusline add extra info: paste mode, Obsession, Git-branch and hunks, etc
function! CodeiumStatus()
  if !has('nvim')
    " if v:version <= 900
    if !has('patch-9.0.0185')
      return printf('OFF')
    else
      return codeium#GetStatusString()
    endif
  else
    return codeium#GetStatusString()
  endif
endfunction
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
function! IsInGitRepo()
  let s:in_git = system("git rev-parse --is-inside-work-tree")
  let s:notidx = match(s:in_git, 'fatal: not a git repository')
  if s:notidx == -1
    return 1
  endif
endfunction
function! GitGetCurrentBranch()
    " NOTE the below command will print 'HEAD' if that's not attached to some branch tip ref
    " :let s:branch_name = system("git rev-parse --abbrev-ref HEAD")
    :let s:branch_name = system("git symbolic-ref -q --short HEAD || echo HEAD")  " this is OK
    :let s:notidx = match(s:branch_name, 'fatal: not a git repository')
    :if s:notidx == -1
        :let s:branch_name = strtrans(s:branch_name)
        :let s:branch_name = s:branch_name[:-3]
        :return '(' . s:branch_name . ') '
    :endif
    :return ''
endfunction
:autocmd BufEnter * silent! lcd %:p:h                       " ask vim to sliently change current dir to path of buffer (so that IsInGitRepo() make no misstake)
highlight StatusVimModeStr ctermfg=Black ctermbg=DarkYellow
set statusline=%#StatusVimModeStr#                          " highlight color for mode() section
set statusline+=%{'-'.toupper(mode(1)).'-'}                 " mode() upper case
set statusline+=%{&paste?'PASTE':''}                        " PASTE indication
set statusline+=%*                                          " Restore default highlight for other sections
set statusline+=\                                           " A space
set statusline+=%<%f                                        " full file path (%< to truncate line if too long)
set statusline+=\                                           " A space
set statusline+=%h%m%r                                      " [help] [+]modified [RO]
set statusline+=%{IsInGitRepo()==1?'':''}                  " Git branch indicator
" set statusline+=%{FugitiveStatusline()}                     " Git current branch name
set statusline+=%{GitGetCurrentBranch()}                    " Git current branch name
set statusline+=%{IsInGitRepo()==1?GitStatus():''}          " GitGutterGetHunkSummary
set statusline+=\                                           " A space
set statusline+=🦜%3{CodeiumStatus()}             " add code-ai status
set statusline+=%=                                          " split left/right sides
set statusline+=%{ObsessionStatus()}                        " Obsession status
set statusline+=\                                           " A space
set statusline+=%-14.(%l,%c%V%)\ %P                         " '-' for left justifying the 'row/col num & percentage'
hi StatusLineNC ctermbg=Black ctermfg=Lightgray
hi StatusLine ctermbg=NONE ctermfg=Blue
" " }}}
" " NERDCOMMENTER ---- {{{
" " Create default mappings
let g:NERDCreateDefaultMappings = 1
" " Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" " Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" " Align line-wise comment delimiters flush left (not following indentation)
let g:NERDDefaultAlign = 'left'
" " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" " Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" " Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" " }}}
" " }}}
" " ================================Part-6: Augroups=========== {{{

" make change in vimrc working immediately --- {{{
augroup BgHighlight
    au!
    au WinEnter * set relativenumber
    au WinLeave * set norelativenumber
augroup END
" }}}

" " vimscript file settings -------------- {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
" " }}}

" " highlight 'long' lines(>= 88 symbols) ------- {{{
augroup filefmt_autocmds
    au!
    " au FileType python,sh,julia,vimwiki,go,tex highlight Excess ctermbg=Lightred guibg=Black
    au FileType python,sh,julia,vimwiki,go,tex highlight Excess ctermbg=Green guibg=Black
    au FileType python,sh,julia,vimwiki,go,tex match Excess /\%88v.*/
    au FileType python,sh,julia,vimwiki,go,tex set colorcolumn=88
    au FileType python,sh,julia,markdown,vimwiki,go,tex set nowrap
    " auto begin in newline when exceed 88 chars when edit these filetypes
    au FileType python,sh,julia,markdown,vimwiki,go,tex setlocal textwidth=88 formatoptions+=t
    " gp for Chinese characters with formatoptions+=mM
    au FileType python,sh,julia,markdown,vimwiki,tex,txt setlocal textwidth=88 formatoptions+=tmM
    " Don't add the comment prefix when I hit enter or o/O on a comment line
    au FileType python,sh,julia,markdown,vimwiki,vim,go,tex setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " no-highlight when concealing (texts or equations)
    au FileType markdown highlight Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
    " Align GitHub-flavored Markdown tables
    au FileType markdown vmap <space><Bslash> :EasyAlign*<Bar><Enter>
    " do not popup docstring windown when using jedi completion
    au FileType python setlocal completeopt-=preview
augroup END
" " }}}

" " no-highlight when concealing (texts or equations) -------------- {{{
" augroup filetype_md
"     au!
"     au BufNewFile,BufRead *.md set filetype=markdown
"     au FileType markdown highlight Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
" augroup END
" " }}}

" " make change in vimrc working immediately --- {{{
"augroup autosrc
"    au! BufWritePost $MYVIMRC source % | echom "Reload " . $MYVIMRC
"augroup END
" " }}}

" " }}}

" " " NOTE that these lines should be put at the end
" if has('packages')
"     " vim8+
"     packloadall
" else
"     " Use Pathogen (on ancient machine perhaps)
"     source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
"     execute pathogen#infect('pack/{}/start/{}')
" endif
