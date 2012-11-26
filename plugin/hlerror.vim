" if exists("loaded_hlerror")
"   finish
" endif
" let loaded_matchit = 1

highlight CompileError ctermbg=red guibg=green

let s:match_ids = []

function! s:DisplayMatches()
  let s:match_ids = []
  for err in getqflist()
    let expr  = '\%' . string(err.lnum) . 'l'
    if err.col != 0
      " some compilers do not report column
      let expr .= '\%' . string(err.col) . 'c'
    endif
    call add(s:match_ids, matchadd("CompileError", expr))
  endfor
endfun

function! s:ClearMatches()
  for match_id in s:match_ids
    call matchdelete(match_id)
  endfo
  let s:match_ids = []
endfun

nnoremap gr :call <SID>DisplayMatches()<cr>
nnoremap gC :call <SID>ClearMatches()<cr>

au QuickFixCmdPost make call s:DisplayMatches()
au QuickFixCmdPre make call s:ClearMatches()
