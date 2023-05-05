let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/grantmacken/worktree/checks
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
edit README.md
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
exe '1resize ' . ((&lines * 16 + 15) / 31)
exe 'vert 1resize ' . ((&columns * 51 + 73) / 147)
exe '2resize ' . ((&lines * 16 + 15) / 31)
exe 'vert 2resize ' . ((&columns * 95 + 73) / 147)
exe '3resize ' . ((&lines * 12 + 15) / 31)
argglobal
balt inc/code.mk
let s:l = 10 - ((9 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 10
normal! 010|
wincmd w
argglobal
if bufexists(".github/workflows/checks.yml") | buffer .github/workflows/checks.yml | else | edit .github/workflows/checks.yml | endif
if &buftype ==# 'terminal'
  silent file .github/workflows/checks.yml
endif
balt .github/workflows/main.yml
let s:l = 27 - ((15 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 27
normal! 028|
wincmd w
argglobal
if bufexists("term://~/projects/grantmacken/worktree/checks//737910:/usr/bin/bash;\#toggleterm\#1") | buffer term://~/projects/grantmacken/worktree/checks//737910:/usr/bin/bash;\#toggleterm\#1 | else | edit term://~/projects/grantmacken/worktree/checks//737910:/usr/bin/bash;\#toggleterm\#1 | endif
if &buftype ==# 'terminal'
  silent file term://~/projects/grantmacken/worktree/checks//737910:/usr/bin/bash;\#toggleterm\#1
endif
balt inc/pods.mk
let s:l = 1310 - ((11 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1310
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 16 + 15) / 31)
exe 'vert 1resize ' . ((&columns * 51 + 73) / 147)
exe '2resize ' . ((&lines * 16 + 15) / 31)
exe 'vert 2resize ' . ((&columns * 95 + 73) / 147)
exe '3resize ' . ((&lines * 12 + 15) / 31)
tabnext 1
badd +61 inc/pods.mk
badd +91 inc/checks.mk
badd +49 inc/code.mk
badd +49 src/code/example.com.xqm
badd +75 inc/certs.mk
badd +28 Makefile
badd +19 inc/confs.mk
badd +1 .github/workflows/reverse-proxy.yml
badd +45 src/proxy/conf/reverse_proxy.conf
badd +18 src/proxy/conf/restxq.conf
badd +62 .github/workflows/main.yml
badd +1 .github/workflows/checks.yml
badd +0 README.md
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
