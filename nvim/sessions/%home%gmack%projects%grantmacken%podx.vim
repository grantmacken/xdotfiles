let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/grantmacken/podx
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
edit inc/code.mk
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 19 + 16) / 32)
exe '2resize ' . ((&lines * 10 + 16) / 32)
argglobal
balt inc/certs.mk
let s:l = 62 - ((12 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 62
normal! 0
wincmd w
argglobal
if bufexists("term://~/projects/grantmacken/podx//744182:/usr/bin/bash;\#toggleterm\#1") | buffer term://~/projects/grantmacken/podx//744182:/usr/bin/bash;\#toggleterm\#1 | else | edit term://~/projects/grantmacken/podx//744182:/usr/bin/bash;\#toggleterm\#1 | endif
if &buftype ==# 'terminal'
  silent file term://~/projects/grantmacken/podx//744182:/usr/bin/bash;\#toggleterm\#1
endif
balt src/code/example.com.xqm
let s:l = 31 - ((9 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 31
normal! 0
wincmd w
exe '1resize ' . ((&lines * 19 + 16) / 32)
exe '2resize ' . ((&lines * 10 + 16) / 32)
tabnext 1
badd +65 inc/checks.mk
badd +33 inc/pods.mk
badd +52 inc/code.mk
badd +14 inc/content.mk
badd +65 ./inc/confs.mk
badd +14 src/code/example.com.xqm
badd +14 README.md
badd +78 inc/certs.mk
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFcI
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
