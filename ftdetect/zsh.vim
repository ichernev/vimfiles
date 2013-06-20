" YES.... YEEEEESSSS
autocmd BufEnter,BufNewFile *.sh if getline(1) =~ '\<zsh\>' | set filetype=zsh | endif
