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
color andrew
set keymap=bulgarian-phonetic-simple
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
set grepprg=xgrep

nmap <Leader>ll :call ToggleLongLines()<CR>
hi ColorColumn ctermbg=blue guibg=cyan

" Persistent undo
set undofile
set undodir=/home/iskren/.vim/undodir
set undolevels=1000  " maximum number of changes that can be undone
set undoreload=10000 " maximum number lines to save for undo on a buffer reload

function! ToggleLongLines()
  if strlen(&colorcolumn) == 0
    set colorcolumn=81
  else
    set colorcolumn=
  endif
endf

nmap <c-c> :cs find c <cword><CR>
let g:ctrlp_map = '<c-a-p>'
nmap <c-p> :CtrlPMixed<CR>
au BufRead,BufNewFile *.ino set filetype=cpp

" command SudoWrite :w !sudo dd of=%

set spelllang=bg,en_us
set nospell
set wildmode=longest:full
set wildmenu

set wildignore+=*.o   " object files
set wildignore+=*.pyc " python bytecode

" CommandT
nnoremap <F5> :CommandTFlush<CR>
nnoremap <Leader>o :CommandT<CR>
nnoremap <Leader>O :tabnew<CR>:CommandT<CR>
nnoremap <Leader>d :CommandT %:h<CR>

" This should be recursive, because <Plug>TaskList is a mapping also
nmap <Leader>t <Plug>TaskList
nmap <Leader>u :GundoToggle<CR>
nmap <Leader>a :%y+<Return>
nmap <silent> <Leader>x /,,,<CR>
nmap <Leader>hb /[а-яА-Я]<CR>

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
nmap <c-e>t <Plug>ToggleQf

" Nerd tree
map gn :NERDTreeToggle<CR>

" Andrew movement
map J 5j
map K 5k
map <Leader>j :join<CR>

" Move visual instead of actual lines
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" Buffer movement
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

" Tab movement
nmap <C-l> gt
nmap <C-h> gT

" Close tab
nnoremap QQ :QuitTab<cr>
command! QuitTab call s:QuitTab()
function! s:QuitTab()
  try
    tabclose
  catch /E784/ " Can't close last tab
    qall
  endtry
endfunction

" a plugin mappings
nnoremap ga :A<CR>

" Very magic searches
nnoremap g/ /\v
nnoremap g? ?\v

set foldmethod=indent
set nofoldenable

" coffee-script
" let coffee_make_options = '--lint' " lint resulting js

autocmd BufWritePre * :%s/\s\+$//e

" pylint
" au FileType python compiler pylint
" let g:pylint_onwrite = 0

" au FileType sass set sw=4

function! ToggleSearchCase()
  set ignorecase!
  set smartcase!
endf

" search helpers
nmap ss :call ToggleSearchCase()<CR>

" surround helpers
nmap s' cs"'
nmap s" cs'"
nmap sd( ds(i <Esc>

" Preview stuff
function! PreviewHelper()
  if exists('b:original_buffer')
    let buffer = bufwinnr(b:original_buffer)
    quit
    exe buffer.'wincmd w'
  else
    if bufwinnr(b:preview_file) < 0
      Preview
    endif

    call s:SwitchWindow(b:preview_file)
  endif
endfunction

nmap gp :call PreviewHelper()<CR>

function! s:SwitchWindow(bufname)
  let window = bufwinnr(a:bufname)
  exe window.'wincmd w'
endfunction

" Smart words
nmap w  <Plug>(smartword-w)
nmap b  <Plug>(smartword-b)
nmap e  <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)

xmap w  <Plug>(smartword-w)
xmap b  <Plug>(smartword-b)
xmap e  <Plug>(smartword-e)
xmap ge <Plug>(smartword-ge)

nnoremap cw cw
nnoremap dw dw
nnoremap yw yw

" J/K work as usual in nerd tree
let g:NERDTreeMapJumpFirstChild = '-'
let g:NERDTreeMapJumpLastChild  = '-'

" Splitjoin
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

function! CoffeeChangeFunctionTypeHelper(symbol)
  if a:symbol == '-'
    return '='
  else
    return '-'
  endif
endfunction
nmap = :s/\%#.*\zs[-=]\ze>/\=CoffeeChangeFunctionTypeHelper(submatch(0))/<cr>
