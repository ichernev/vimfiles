nnoremap <Plug>ToggleQf :call <SID>ToggleQf()<cr>

function! s:ToggleQf()
  for buffer in tabpagebuflist()
    if bufname(buffer) == ''
      " then it should be the quickfix window
      cclose
      return
    endif
  endfor

  copen
endfunction
