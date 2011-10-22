" perdirvimrc.vim
"
" Author: Wolfgang Plaschg <wolfgang.plaschg at gmail.com>
" Version: 0.2
" Last Change: 2009-09-23
"
" This script loads Vim configuration files at startup beginning
" from the root directory down to the current working directory.
"
" This is useful when you want to to set up a specific configuration that
" is only loaded when you edit files within a certain directory.
" 
" Let's look at a common situation. To configure Vim depending on your
" project, your tree would look like this:
"
" ~/projects                       Your programming projects
" ~/projects/.vim                  Vim settings for your projects
" ~/projects/c-projects            Your projects written in C
" ~/projects/c-projects/.vim       Vim settings for your C projects
" ~/projects/php-projects          Your projects written in PHP
" ~/projects/php-projects/.vim     Vim settings for your PHP projects
"
" When you open the file ~/projects/c-projects/main.c the plugin loads
" this files in the given order:
"
" ~/projects/.vim
" ~/projects/c-projects/.vim
"
" The scripts autoloads files with the name
"
"      _vimrc
"      _vim
"      .vimrc
"      .vim
"

if exists("perdirvimrc_loaded")
	finish
endif
let perdirvimrc_loaded = 1

if (has("win32") || has("gui_win32") || has("gui_win32s") || has("win16") || has("win64") || has("win32unix") || has("win95")) && &shell != "bash"
	" windows
	let s:dir_separator = '\'
	let s:vimrc = ['_vimrc', '_vim', '.vim', '.vimrc']
	let s:unix = 0
else
	" unix
	let s:dir_separator = '/'
	let s:vimrc = ['.vim', '.vimrc', '_vimrc', '_vim']
	let s:unix = 1
endif

function! LoadVimRes(path)
	let s:dirlist = split(a:path, s:dir_separator) 
	let s:j = 0
	let s:subdir = []
	while s:j < len(s:dirlist)
	  call add(s:subdir, s:dirlist[s:j])

	  let s:k = 0
	  while s:k < len(s:vimrc)
		" load s:vimrc1
		let s:filename = join(s:subdir, s:dir_separator).s:dir_separator.s:vimrc[s:k]
		if s:unix == 1
			let s:filename = s:dir_separator . s:filename
		endif
		if filereadable(s:filename) != 0
		   exe 'source '.s:filename
		endif
		let s:k = s:k + 1
	  endwhile

	  let s:j = s:j + 1
	endwhile
endfunction

call LoadVimRes(getcwd())
autocmd BufRead * call LoadVimRes(expand('%:p:h'))
