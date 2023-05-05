let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/grantmacken
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
edit dots/configs/.config/kitty/session.conf
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
exe '1resize ' . ((&lines * 23 + 18) / 36)
exe 'vert 1resize ' . ((&columns * 78 + 73) / 147)
exe '2resize ' . ((&lines * 23 + 18) / 36)
exe 'vert 2resize ' . ((&columns * 68 + 73) / 147)
exe '3resize ' . ((&lines * 10 + 18) / 36)
argglobal
balt dots/bin/tk
let s:l = 16 - ((15 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 16
normal! 0
wincmd w
argglobal
if bufexists("dots/configs/.config/kitty/kitty.conf") | buffer dots/configs/.config/kitty/kitty.conf | else | edit dots/configs/.config/kitty/kitty.conf | endif
if &buftype ==# 'terminal'
  silent file dots/configs/.config/kitty/kitty.conf
endif
balt dots/kitty.session
let s:l = 5 - ((4 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 011|
wincmd w
argglobal
if bufexists("term://~/projects/grantmacken//302142:/usr/bin/bash;\#toggleterm\#1") | buffer term://~/projects/grantmacken//302142:/usr/bin/bash;\#toggleterm\#1 | else | edit term://~/projects/grantmacken//302142:/usr/bin/bash;\#toggleterm\#1 | endif
if &buftype ==# 'terminal'
  silent file term://~/projects/grantmacken//302142:/usr/bin/bash;\#toggleterm\#1
endif
balt dots/bin/tk
let s:l = 72 - ((9 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 72
normal! 0
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 23 + 18) / 36)
exe 'vert 1resize ' . ((&columns * 78 + 73) / 147)
exe '2resize ' . ((&lines * 23 + 18) / 36)
exe 'vert 2resize ' . ((&columns * 68 + 73) / 147)
exe '3resize ' . ((&lines * 10 + 18) / 36)
tabnext 1
badd +51 dots/configs/.config/nvim/init.lua
badd +12 dots/bin/tmux-sessionizer
badd +48 dots/configs/.config/alacritty/alacritty.yml
badd +12 dots/configs/.config/tmux/tmux.conf
badd +2 dots/configs/.config/kitty/kitty.conf
badd +3 dots/bin/tk
badd +1 dots/bin/italicsInVimInsideTmux.sh
badd +7 dots/configs/.config/kitty/session.conf
badd +4 dots/kitty.session
badd +1 dots/Makefile
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
