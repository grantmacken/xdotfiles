let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/grantmacken/fluorescence
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
edit site/gmack.nz/code/routes.xqm
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
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
exe 'vert 1resize ' . ((&columns * 118 + 73) / 147)
exe 'vert 2resize ' . ((&columns * 28 + 73) / 147)
argglobal
balt gcloud/Makefile
let s:l = 43 - ((20 * winheight(0) + 14) / 29)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 43
normal! 012|
wincmd w
argglobal
if bufexists(".inc/common.mk") | buffer .inc/common.mk | else | edit .inc/common.mk | endif
if &buftype ==# 'terminal'
  silent file .inc/common.mk
endif
balt gcloud/Makefile
let s:l = 40 - ((6 * winheight(0) + 14) / 29)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 40
let s:c = 24 - ((21 * winwidth(0) + 14) / 28)
if s:c > 0
  exe 'normal! ' . s:c . '|zs' . 24 . '|'
else
  normal! 024|
endif
wincmd w
exe 'vert 1resize ' . ((&columns * 118 + 73) / 147)
exe 'vert 2resize ' . ((&columns * 28 + 73) / 147)
tabnext 1
badd +86 .inc/xqContainer.mk
badd +79 gcloud/Makefile
badd +40 .inc/common.mk
badd +0 site/gmack.nz/code/routes.xqm
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
