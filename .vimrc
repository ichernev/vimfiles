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

function! ToggleLongLines() 
  if strlen(&colorcolumn) == 0
    set colorcolumn=81
  else
    set colorcolumn=
  endif
endf

" command SudoWrite :w !sudo dd of=%

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
nnoremap <c-e>t :QFix<CR>

" Nerd tree
map gn :NERDTreeToggle<CR>

" Andrew movement
map J 5j
map K 5k
map <Leader>j :join<CR>

set foldmethod=indent
set nofoldenable

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
