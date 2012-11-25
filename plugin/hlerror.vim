" if exists("loaded_hlerror")
"   finish
" endif
" let loaded_matchit = 1

highlight CompileError ctermbg=red guibg=green

let s:match_ids = []

function! s:FooIsBar()
  let s:match_ids = []
  for err in getqflist()
    let expr  = '\%' . string(err.lnum) . 'l'
    let expr .= '\%' . string(err.col) . 'c'
    call add(s:match_ids, matchadd("CompileError", expr))
  endfor
endfun

function! s:BarIsFoo()
  for match_id in s:match_ids
    call matchdelete(match_id)
  endfo
  let s:match_ids = []
endfun

nnoremap gr :call <SID>FooIsBar()<cr>
nnoremap gC :call <SID>BarIsFoo()<cr>

au QuickFixCmdPost make call s:FooIsBar()
au QuickFixCmdPre make call s:BarIsFoo()
