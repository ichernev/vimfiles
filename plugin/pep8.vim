if exists("loaded_pep8")
  finish
endif

let loaded_pep8 = 1

if !exists("g:pep8_enabled")
  let g:pep8_enabled = 1
endif

if !exists("g:pep8_cmd_line")
  let g:pep8_cmd_line = 'pep8 %'
endif

function! s:Pep8()
  if !g:pep8_enabled
    return
  endif

  let makeprg_backup = &makeprg
  let &makeprg = g:pep8_cmd_line
  silent make! | redraw!
  let &makeprg = makeprg_backup

  let error_count = len(getqflist())
  " echon "got " . error_count . " error"
  " if error_count == 0
  "   echo "s"
  " endif

  if error_count == 1
    echo "got " . error_count . " error"
  elseif error_count > 1
    echo "got " . error_count . " errors"
  endif
endf

augroup pep8
  au!
  au BufWritePost *.py call <SID>Pep8()
augroup END

