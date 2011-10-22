set ts=8
set sts=0
set sw=8
set noexpandtab

set cino=:0,t0,g0,(0
map <F4> :e %:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
