let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/grantmacken/pods
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
edit Makefile
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
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
exe '1resize ' . ((&lines * 18 + 15) / 31)
exe 'vert 1resize ' . ((&columns * 115 + 73) / 147)
exe '2resize ' . ((&lines * 18 + 15) / 31)
exe 'vert 2resize ' . ((&columns * 31 + 73) / 147)
exe '3resize ' . ((&lines * 10 + 15) / 31)
argglobal
balt .env
let s:l = 72 - ((14 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 72
normal! 012|
wincmd w
argglobal
if bufexists("pod-podx.service") | buffer pod-podx.service | else | edit pod-podx.service | endif
if &buftype ==# 'terminal'
  silent file pod-podx.service
endif
balt .env
let s:l = 16 - ((6 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 16
normal! 011|
wincmd w
argglobal
if bufexists("term://~/projects/grantmacken/pods//6318:/usr/bin/bash;\#toggleterm\#1") | buffer term://~/projects/grantmacken/pods//6318:/usr/bin/bash;\#toggleterm\#1 | else | edit term://~/projects/grantmacken/pods//6318:/usr/bin/bash;\#toggleterm\#1 | endif
if &buftype ==# 'terminal'
  silent file term://~/projects/grantmacken/pods//6318:/usr/bin/bash;\#toggleterm\#1
endif
balt Makefile
let s:l = 287 - ((9 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 287
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 18 + 15) / 31)
exe 'vert 1resize ' . ((&columns * 115 + 73) / 147)
exe '2resize ' . ((&lines * 18 + 15) / 31)
exe 'vert 2resize ' . ((&columns * 31 + 73) / 147)
exe '3resize ' . ((&lines * 10 + 15) / 31)
tabnext 1
badd +17 ~/projects/grantmacken/alpine-openresty/Makefile
badd +60 Makefile
badd +204 ~/projects/grantmacken/alpine-openresty/Dockerfile
badd +1 /run/media/gmack/bu/grantmacken/projects/grantmacken/alpine-openresty/_hold.md
badd +7 .env
badd +16 pod-podx.service
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
