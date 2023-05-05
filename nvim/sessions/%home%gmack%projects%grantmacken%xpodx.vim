let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/grantmacken/xpodx
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
tabnext 1
badd +49 src/code/example.com.xqm
badd +18 inc/pods.mk
badd +40 src/code/req_res.xqm
badd +47 inc/content.mk
badd +11 inc/proxy-conf.mk
badd +10 src/proxy/conf/example.conf
badd +83 src/proxy/conf/locations.conf
badd +201 inc/build.mk
badd +15 inc/code.mk
badd +1 src/data/example.com/content/articles/tasklist.md
badd +16 src/data/example.com/content/home/index.md
badd +3 src/data/example.com/content/home/index.json
badd +82 bin/xq
badd +13 src/escripts/query.escript
badd +1 src/data/example.com/content/home/index.xq
badd +11 src/escripts/run.escript
badd +8 src/escripts/run2.escript
badd +14 src/code/store-func.xq
badd +1 src/code/store.xq
badd +17 src/main_modules/wrap.xq
badd +20 src/main_modules/db-item-type.xq
badd +5 src/main_modules/turtles.xq
badd +12 src/code/db-item-type.xq
badd +1 term://~/projects/grantmacken/podx//64888:/usr/bin/bash
badd +285 term://~/projects/grantmacken/podx//64931:/usr/bin/bash
badd +1 example.pem
badd +1 term
badd +2 term://~/projects/grantmacken/podx//65683:/usr/bin/bash
badd +4 term://~/projects/grantmacken/podx//65733:/usr/bin/bash
badd +144 src/code/cmarkup.xqm
badd +8 src/data/example.com/content/articles/index.md
badd +29 README.md
badd +189 term://~/projects/grantmacken/podx//81908:/usr/bin/bash
badd +4 .gitignore
badd +29 .github/workflows/main.yml
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFcI
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
