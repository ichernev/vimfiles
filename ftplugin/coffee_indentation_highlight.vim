inoremap <buffer> <bs> <bs><c-r>=<SID>HighlightMatchingIndent()<cr>
inoremap <buffer> <tab> <tab><c-r>=<SID>HighlightMatchingIndent()<cr>

autocmd InsertLeave <buffer> match none

function! s:HighlightMatchingIndent()
  let indent = indent(line('.'))

  if indent == -1
    return ''
  endif

  let whitespace = repeat(' ', indent)
  exe 'match MatchParen /^'.whitespace.'\zs\S/'

  return ''
endfunction
