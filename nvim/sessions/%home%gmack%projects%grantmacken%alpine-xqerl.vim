let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/grantmacken/alpine-xqerl
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd Makefile
edit Dockerfile
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
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
exe '1resize ' . ((&lines * 11 + 18) / 37)
exe 'vert 1resize ' . ((&columns * 58 + 73) / 147)
exe '2resize ' . ((&lines * 8 + 18) / 37)
exe 'vert 2resize ' . ((&columns * 58 + 73) / 147)
exe '3resize ' . ((&lines * 20 + 18) / 37)
exe 'vert 3resize ' . ((&columns * 88 + 73) / 147)
exe '4resize ' . ((&lines * 14 + 18) / 37)
argglobal
balt Makefile
let s:l = 45 - ((7 * winheight(0) + 5) / 11)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 45
normal! 022|
wincmd w
argglobal
if bufexists(".env") | buffer .env | else | edit .env | endif
if &buftype ==# 'terminal'
  silent file .env
endif
balt Makefile
let s:l = 5 - ((4 * winheight(0) + 4) / 8)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 026|
wincmd w
argglobal
if bufexists(".env") | buffer .env | else | edit .env | endif
if &buftype ==# 'terminal'
  silent file .env
endif
balt .github/workflows/main.yml
let s:l = 20 - ((16 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 20
normal! 018|
wincmd w
argglobal
if bufexists("term://~/projects/grantmacken/alpine-xqerl//198639:/usr/bin/bash;\#toggleterm\#1") | buffer term://~/projects/grantmacken/alpine-xqerl//198639:/usr/bin/bash;\#toggleterm\#1 | else | edit term://~/projects/grantmacken/alpine-xqerl//198639:/usr/bin/bash;\#toggleterm\#1 | endif
if &buftype ==# 'terminal'
  silent file term://~/projects/grantmacken/alpine-xqerl//198639:/usr/bin/bash;\#toggleterm\#1
endif
balt Dockerfile
let s:l = 147 - ((13 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 147
normal! 0
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 11 + 18) / 37)
exe 'vert 1resize ' . ((&columns * 58 + 73) / 147)
exe '2resize ' . ((&lines * 8 + 18) / 37)
exe 'vert 2resize ' . ((&columns * 58 + 73) / 147)
exe '3resize ' . ((&lines * 20 + 18) / 37)
exe 'vert 3resize ' . ((&columns * 88 + 73) / 147)
exe '4resize ' . ((&lines * 14 + 18) / 37)
tabnext 1
badd +10 Makefile
badd +0 .env
badd +45 Dockerfile
badd +68 inc/container.mk
badd +35 .github/workflows/main.yml
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
