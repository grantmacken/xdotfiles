let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/grantmacken/dots/bin
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
edit italicsInVimInsideTmux.sh
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
exe '1resize ' . ((&lines * 18 + 18) / 36)
exe 'vert 1resize ' . ((&columns * 73 + 73) / 147)
exe '2resize ' . ((&lines * 18 + 18) / 36)
exe 'vert 2resize ' . ((&columns * 73 + 73) / 147)
exe '3resize ' . ((&lines * 15 + 18) / 36)
argglobal
balt ~/projects/grantmacken/dots/configs/.config/bash/prompt.sh
let s:l = 6 - ((5 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6
normal! 026|
wincmd w
argglobal
if bufexists("~/projects/grantmacken/dots/configs/.config/bash/prompt.sh") | buffer ~/projects/grantmacken/dots/configs/.config/bash/prompt.sh | else | edit ~/projects/grantmacken/dots/configs/.config/bash/prompt.sh | endif
if &buftype ==# 'terminal'
  silent file ~/projects/grantmacken/dots/configs/.config/bash/prompt.sh
endif
balt italicsInVimInsideTmux.sh
let s:l = 5 - ((4 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 04|
wincmd w
argglobal
if bufexists("term://~/projects/grantmacken/dots//108034:/usr/bin/bash;\#toggleterm\#1") | buffer term://~/projects/grantmacken/dots//108034:/usr/bin/bash;\#toggleterm\#1 | else | edit term://~/projects/grantmacken/dots//108034:/usr/bin/bash;\#toggleterm\#1 | endif
if &buftype ==# 'terminal'
  silent file term://~/projects/grantmacken/dots//108034:/usr/bin/bash;\#toggleterm\#1
endif
balt ~/projects/grantmacken/dots/configs/.config/nvim/lua/plugins.lua
let s:l = 11 - ((10 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 11
normal! 0
wincmd w
exe '1resize ' . ((&lines * 18 + 18) / 36)
exe 'vert 1resize ' . ((&columns * 73 + 73) / 147)
exe '2resize ' . ((&lines * 18 + 18) / 36)
exe 'vert 2resize ' . ((&columns * 73 + 73) / 147)
exe '3resize ' . ((&lines * 15 + 18) / 36)
tabnext 1
badd +39 ~/projects/grantmacken/dots/configs/.config/alacritty/alacritty.yml
badd +11 ~/projects/grantmacken/dots/configs/.config/tmux/tmux.conf
badd +0 term://~/projects/grantmacken/dots//108034:/usr/bin/bash;\#toggleterm\#1
badd +19 ~/projects/grantmacken/dots/configs/.config/nvim/lua/plugins.lua
badd +140 ~/projects/grantmacken/dots/configs/.config/nvim/init.lua
badd +13 ~/projects/grantmacken/dots/configs/.bashrc
badd +14 ~/projects/grantmacken/dots/configs/.config/bash/aliasesAndExports.sh
badd +6 italicsInVimInsideTmux.sh
badd +5 ~/projects/grantmacken/dots/configs/.config/bash/prompt.sh
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFIc
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
