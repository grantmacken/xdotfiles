let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/grantmacken/podx-alpine
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
exe '1resize ' . ((&lines * 12 + 12) / 25)
exe 'vert 1resize ' . ((&columns * 128 + 65) / 130)
exe '2resize ' . ((&lines * 12 + 12) / 25)
exe 'vert 2resize ' . ((&columns * 1 + 65) / 130)
exe '3resize ' . ((&lines * 10 + 12) / 25)
argglobal
balt .env
let s:l = 18 - ((4 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 18
normal! 022|
wincmd w
argglobal
if bufexists(".env") | buffer .env | else | edit .env | endif
if &buftype ==# 'terminal'
  silent file .env
endif
balt .github/workflows/main.yml
let s:l = 7 - ((6 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 7
normal! 0
wincmd w
argglobal
if bufexists("term://~/projects/grantmacken/podx-alpine//121900:/usr/bin/bash;\#toggleterm\#1") | buffer term://~/projects/grantmacken/podx-alpine//121900:/usr/bin/bash;\#toggleterm\#1 | else | edit term://~/projects/grantmacken/podx-alpine//121900:/usr/bin/bash;\#toggleterm\#1 | endif
if &buftype ==# 'terminal'
  silent file term://~/projects/grantmacken/podx-alpine//121900:/usr/bin/bash;\#toggleterm\#1
endif
balt Makefile
let s:l = 131 - ((9 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 131
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 12 + 12) / 25)
exe 'vert 1resize ' . ((&columns * 128 + 65) / 130)
exe '2resize ' . ((&lines * 12 + 12) / 25)
exe 'vert 2resize ' . ((&columns * 1 + 65) / 130)
exe '3resize ' . ((&lines * 10 + 12) / 25)
tabnext 1
badd +12 Makefile
badd +7 .env
badd +10 .github/workflows/main.yml
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
