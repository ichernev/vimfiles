" call pathogen#infect()
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'jslint')
call pathogen#runtime_append_all_bundles()
syntax on
set noswapfile
set winwidth=80
set fileencodings=utf-8,cp1251
"set number
set autoindent
set ruler
set ignorecase      " when searching
set smartcase       " case matters when seach pattern has upper case
set hlsearch
set incsearch
filetype plugin indent on
set ts=8
set sw=2
set sts=2
set expandtab
color elflord
set keymap=bulgarian-phonetic
set iminsert=0
set imsearch=-1
set mousefocus     " focus follows mouse
set mouse=a
set formatoptions=1 " connected with the next one
set lbr             " word wrap (on word, not screen)
if has('gui_running')
  " set showtabline=2   " always show tab line
  set guioptions=aci
  set guifont=Monospace\ 10
endif
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set laststatus=2    " always show status line
":au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
":au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" nmap <Up>    gk
" nmap <Down>  gj
" imap <Up>    <Esc>gka
" imap <Down>  <Esc>gja
" Move between windows in one click
" nmap  <M-l>         <C-W><Right>
" nmap  <M-h>         <C-W><Left>
" nmap  <M-j>         <C-W><Down>
" nmap  <M-k>         <C-W><Up>
" map! <Home>  g_
" map! <End>   g$
" nmap <C-a>  :%y+<Return>
set spelllang=bg,en_us
set nospell
set wildmode=longest:full
set wildmenu

nnoremap <Leader>o :CommandT<CR>
" This should be recursive, because <Plug>TaskList is a mapping also
nmap <Leader>t <Plug>TaskList
nmap <Leader>u :GundoToggle<CR>
nmap <Leader>a :%y+<Return>
nmap <silent> <Leader>x /,,,<CR>

" Java Script linting
function! JsLint()
  " call system('jslint --config ' . expand('$HOME/.jslint.json') .
  "       \expand("%") . ' | tee /tmp/linting | /dev/null')
  " cfile '/tmp/linting'
  cgetexpr system(printf('jslint --config %s %s', 
        \expand('$HOME/.jslint.json'), expand('%')))
endf
augroup jslint
  au!
  au BufWritePost *.js call JsLint()
augroup END

" Quickfix stuff
nnoremap <c-e>j :cn<CR>
nnoremap <c-e>k :cp<CR>
nnoremap <c-e>t :QFix<CR>

" coffee-script
let coffee_make_options = '--lint' " lint resulting js

" highlight whitespace
" highlight ExtraWhitespace ctermbg=red guibg=red
" au ColorScheme * highlight ExtraWhitespace guibg=red
" au BufEnter * match ExtraWhitespace /\s\+$/
" au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" au InsertLeave * match ExtraWhiteSpace /\s\+$/

" pylint
" au FileType python compiler pylint
" let g:pylint_onwrite = 0

au FileType javascript set nocindent
" au FileType sass set sw=4

"" Toggle encodings -- I don't need this, because of fileencodings option set
"" at the top.
" function! ChangeFileencoding()
"   let encodings = ['cp1251', 'koi8-u', 'cp866']
"   let prompt_encs = []
"   let index = 0
"   while index < len(encodings)
"     call add(prompt_encs, index.'. '.encodings[index])
"     let index = index + 1
"   endwhile
"   let choice = inputlist(prompt_encs)
"   if choice >= 0 && choice < len(encodings)
"     execute 'e ++enc='.encodings[choice].' %:p'
"   endif
" endf
" nmap <F8> :call ChangeFileencoding()<CR>

function! ToggleSearchCase()
  set ignorecase!
  set smartcase!
endf

nmap ss :call ToggleSearchCase()<CR>
