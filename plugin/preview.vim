" This script makes it easy to generate the preview of a file using some
" external program. This could probably be used for any kind of file that
" requires some preprocessing before usage, like coffeescript or markdown.
"
" The preview's parameters are defined using the function SetupPreview. Its
" first parameter is the extension of the processed filetype, the second one
" is the shell command to execute, with %s being replaced by the current
" file's filename.
"
" Examples:
"
"   call SetupPreview('js', 'coffee -p %s')
"   call SetupPreview('markdown', 'markdown %s')
"
" To open up the preview window use the command :Preview. After that, it will
" be updated upon saving the original buffer.

command! Preview call s:InitPreview()

function! SetupPreview(extension, command)
  let b:preview_file    = tempname().'.'.a:extension
  let b:preview_command = printf(a:command, shellescape(expand('%')))
  let b:preview_command .= ' > ' . b:preview_file . ' 2>&1'

  autocmd BufWritePost <buffer>
        \ if bufwinnr(b:preview_file) >= 0 |
        \   call UpdatePreview()           |
        \ endif
  autocmd BufUnload <buffer>
        \ if bufwinnr(b:preview_file) >= 0      |
        \   call s:SwitchWindow(b:preview_file) |
        \   quit                                |
        \ endif
endfunction

function! s:InitPreview()
  if !exists('b:preview_file')
    echoerr 'No preview command has been defined for this buffer.'
  endif

  if bufwinnr(b:preview_file) < 0
    exe 'rightbelow vsplit '.b:preview_file
    let b:original_buffer = bufnr('#')
    call s:SwitchWindow(b:original_buffer)
  endif

  call UpdatePreview()
endfunction

function! UpdatePreview()
  if !exists('b:preview_file') || bufwinnr(b:preview_file) < 0
    return
  endif

  call system(b:preview_command)

  call s:SwitchWindow(b:preview_file)
  silent edit!
  syntax on " workaround for weird lack of syntax
  normal! zR
  call s:SwitchWindow(b:original_buffer)
endfunction

" Switch to the window that a:bufname is located in.
function! s:SwitchWindow(bufname)
  let window = bufwinnr(a:bufname)
  exe window.'wincmd w'
endfunction
