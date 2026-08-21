" ================================ ~/.vimrc ===== {{{
" vim-specific config: plugins only.
" Basic settings live in ~/.vimrc.basic (shared with nvim).
" Plugin management: vim built-in pack (see ~/.vim/pack)
" Last-update: 2024-08-22 Thu

source ~/.vimrc.basic

" " ================================Part-5: Plugin Config====== {{{
" " clang-format ---- {{{
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" " Toggle auto formatting:
" nmap <Leader>C :ClangFormatAutoToggle<CR>
" " }}}
" " ycm ----------------------------- {{{
nmap <leader>gd :YcmDiags<CR>
nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
let g:ycm_goto_buffer_command = 'split-or-existing-window'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_cache_omnifunc = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_filetype_blacklist = {'tex' : 1, 'markdown' : 1, 'text' : 1, 'html' : 1}
let g:syntastic_ignore_files = [".*\.py$"] "python has its own check engine
"let g:ycm_semantic_triggers = {}
"let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&']
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" " }}}
" " " fswitch ------ {{{
" let b:fswitchdst = 'cpp,cxx,C'
" " " }}}
" " easyAlign ----------------------------- {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
au FileType * vmap <space><Bslash> :EasyAlign*<Bar><Enter>
" " }}}
" " Obsession ----------------------------- {{{
function! StartObsessionInProjectRoot()
    " Find the directory containing the .git directory
    let l:root = finddir('.git', '.;')
    if !empty(l:root)
        " Remove the .git part to get the project root directory
        let l:root = fnamemodify(l:root, ':h')
        execute 'cd' fnameescape(l:root)
    endif
    " Start Obsession
    Obsession
endfunction
" Command to start obsession in the project root
command! ObsessRoot call StartObsessionInProjectRoot()
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
let g:jedi#show_call_signatures = "2"
" " transparent jedi#show_call_signatures bg/fg color
hi Function ctermbg=none ctermfg=blue
hi jediFat ctermbg=none ctermfg=DarkRed
hi jediFunction ctermbg=none ctermfg=LightRed
" " }}}
" " vim-easymotion --------------- {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1  " Turn on case-insensitive feature
" " <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
" " Need one more keystroke, but on average, it may be more comfortable.
" " s{char}{char} to move to {char}{char}, <leader>s work too
nmap s <Plug>(easymotion-overwin-f2)
" " JK motions: Line motions (relative linenum is good-enough for me)
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
let g:tex_conceal = ""
let g:vim_markdown_math = 1
" " Disabling conceal for code fences requires an additional setting:
let g:vim_markdown_conceal_code_blocks = 0
" " do not require .md extensions for Markdown links '[link text](link-url)'
" " using the 'ge' command to open link-url.md instead of the file link-url
let g:vim_markdown_no_extensions_in_markdown = 1
" " how to open new files [tab, vsplit, hsplit, current]
let g:vim_markdown_edit_url_in = 'hsplit'
" " go to next header
map ]] <Plug>Markdown_MoveToNextHeader
map [[ <Plug>Markdown_MoveToPreviousHeader
map [] <Plug>Markdown_MoveToNextSiblingHeader
map ][ <Plug>Markdown_MoveToPreviousSiblingHeader
" " disable ']h': go to current header (conflict to gitgutter's)
map <Plug> <Plug>Markdown_MoveToCurHeader
" " HeaderIncrease and HeaderDecrease
function! HeaderIncrease()
    %s/^#/##/g
endfunction
command! HLI call HeaderIncrease()
function! HeaderDecrease()
    %s/^##/#/g
endfunction
command! HLD call HeaderDecrease()
" " }}}
" " netrw gitignore ------------- {{{
" " 默认垂直分新窗口到左边；这里设置为分到右边
let g:netrw_altv = 1
" " 仅仅打开目录栏比较合适；当直接从目录栏打开文件编辑时就蛋疼
" let g:netrw_winsize = 22
let g:netrw_liststyle = 0
" let g:netrw_list_hide= netrw_gitignore#Hide()
"let g:netrw_list_hide= netrw_gitignore#Hide('my_gitignore_file')
" let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" " }}}
" " tagbar toggle---------------- {{{
let g:tagbar_sort = 0
let g:tagbar_width = 28
let g:tagbar_autofocus = 1
let g:tagbar_position = 'topleft vertical'
let g:tagbar_ctags_bin = "/home/fmh/ctags/uctags-2023.04.16-linux-x86_64/bin/ctags"
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
command Todo Ack 'TODO|FIXME|REFACTOR|HACK'
command Info Ack 'NOTE|INFO|IDEA|DEBUGGING'
" " }}}
" " ALE ---- {{{
" Write this in your vimrc file
let g:ale_python_ruff_auto_pipenv = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
let g:ale_sign_error = '☒'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%-%code%] %s'
let g:ale_set_highlights = 1
" let g:ale_floating_window_border = repeat([''], 8)
" " Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
" " pylint too noisy
"    \   'python': ['flake8', 'pylint'],
let g:ale_linters = {
    \   'python': ['ruff',],
    \}
let g:ale_fixers = {
            \   'python': ['ruff', 'black', 'isort'],
            \   'sql': ['pgformatter'],
            \}
" " Bind F9 to fixing problems with ALE
nmap <F9> <Plug>(ale_fix)
" " jump to warps
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
" " }}}
" " FZF and GITGUTTER ---- {{{
" " using fzf
set rtp+=~/.fzf
" " fzf shotcut, NOTE the :G means Gitgutter is needed
imap <c-x><c-o> <plug>(fzf-complete-line)
map <space>t :Tags<cr>
map <space>b :Buffers<cr>
map <space>f :Gcd <bar> Files<cr>
map <space>g :GFiles<cr>
" " commit with verbose info
nnoremap <space>c :G commit -v<cr>
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
let g:gitgutter_preview_win_floating = 1
" " }}}
" " Hands on STATUSLINE ---- {{{
" " statusline add extra info: paste mode, Obsession, Git-branch and hunks, etc
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
" highlight StatusVimModeStr ctermfg=Black ctermbg=NONE
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
set statusline+=%=                                          " split left/right sides
set statusline+=%{ObsessionStatus()}                        " Obsession status
set statusline+=\                                           " A space
set statusline+=%-14.(%l,%c%V%)\ %P                         " '-' for left justifying the 'row/col num & percentage'
hi StatusLineNC ctermbg=Black ctermfg=Blue
hi StatusLine ctermbg=NONE ctermfg=Green
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

" " " NOTE that these lines should be put at the end
" if has('packages')
"     " vim8+
"     packloadall
" else
"     " Use Pathogen (on ancient machine perhaps)
"     source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
"     execute pathogen#infect('pack/{}/start/{}')
" endif
