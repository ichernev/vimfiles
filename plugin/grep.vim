" Can be called in several ways:
"
"   :Grep <something> " -> Grep for the given search query
"   :Grep             " -> Grep for the word under the cursor
"   :'<,'>Grep        " -> Grep in visual mode
"
command! -count=0 -nargs=* Grep call s:Grep(<count>, <q-args>)
function! s:Grep(count, args)
  if a:count > 0
    " then we've selected something in visual mode
    let query = s:LastSelectedText()
  elseif empty(a:args)
    " If no pattern is provided, search for the word under the cursor
    let query = expand("<cword>")
  else
    let query = a:args
  end

  exe 'grep -r '.query.' .'
endfunction

function! s:LastSelectedText()
  let saved_cursor = getpos('.')

  let original_reg      = getreg('z')
  let original_reg_type = getregtype('z')

  normal! gv"zy
  let text = @z

  call setreg('z', original_reg, original_reg_type)
  call setpos('.', saved_cursor)

  return text
endfunction
