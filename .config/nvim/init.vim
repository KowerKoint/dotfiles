"行番号を表示
set number
"タブ文字の代わりにスペースを使う
set expandtab
"プログラミング言語に合わせて適切にインデントを自動挿入
set smartindent
"各コマンドやsmartindentで挿入する空白の量
set shiftwidth=2
"Tabキーで挿入するスペースの数
set softtabstop=2
"カレントディレクトリを自動で移動
set autochdir
"バッファ内で扱う文字コード
set encoding=utf-8
"書き込む文字コード : この場合encodingと同じなので省略可
set fileencoding=utf-8
"読み込む文字列 : この場合UTF-8を試し、だめならShift_JIS
set fileencodings=utf-8,cp932
"Vimの無名レジスタとシステムのクリップボードを連携 : ダメならxclipをインストールで使えるかも
set clipboard+=unnamed,unnamedplus
"eコマンド等でTabキーを押すとパスを保管する : この場合まず最長一致文字列まで保管し、2回目以降は一つづつ試す
set wildmode=longest,full

"LeaderキーをSpaceに設定(これだけでは意味をなさない)
let mapleader = "\<Space>"

"xでレジスタに入れない
nnoremap x "_x
"矢印上下で折り返しを含めた移動
nnoremap <Down> gj
nnoremap <Up> gk
"C++,Java等のインラインブロックを中括弧付きのブロックに展開
nnoremap <C-j> ^/(<CR>%a{<CR><Esc>o}<Esc>
"カーソル上の単語を置換
nnoremap <expr> S* ':%s/\<' . expand('<cword>') . '\>/'

"挿入モード終了時にIMEをオフ：ダメならfcitxとfcitx-mozcをインストールして設定
inoremap <silent> <Esc> <Esc>:<C-u>call system('fcitx-remote -c')<CR>

"新しい行にペーストする
nnoremap <silent> <C-p> :<C-u>put .<CR>

imap <Nul> <Nop>

"下部分にターミナルウィンドウを作る
function! Myterm()
  split
  wincmd j
  resize 10
  terminal
  wincmd k
endfunction
command! Myterm call Myterm()

"起動時にターミナルウィンドウを設置
if has('vim_starting')
  Myterm
endif

"上のエディタウィンドウと下のターミナルウィンドウ(ターミナル挿入モード)を行き来
tnoremap <C-t> <C-\><C-n><C-w>k
nnoremap <C-t> <C-w>ji
"ターミナル挿入モードからターミナルモードへ以降
tnoremap <Esc> <C-\><C-n>

"ファイルタイプごとにコンパイル/実行コマンドを定義
function! Setup()
  "フルパスから拡張子を除いたもの
  let l:no_ext_path = printf("%s/%s", expand("%:h"), expand("%:r"))
  "各言語の実行コマンド
  let g:compile_command_dict = {
        \'c': printf('gcc -std=gnu11 -O2 -lm -o %s %s && %s', expand("%:p:r"), expand("%:p"), expand("%:p:r")),
        \'cpp': printf('g++ -I$HOME/mylib/ac-library -std=gnu++17 -O2 -o %s.out %s && %s.out', expand("%:p:r"), expand("%:p"), expand("%:p:r")),
        \'java': printf('cd %s && javac %s && java %s', expand("%:p:h"), expand("%:p"), expand("%:t:r")),
        \'python': printf('python3 %s', expand("%:p")),
        \'ruby': printf('ruby %s', expand("%:p")),
        \'javascript': printf('node %s', expand("%:p")),
        \'sh': printf('chmod u+x %s && %s', expand("%:p"), expand("%:p")),
        \'rust': printf('rustc -A dead_code -o %s %s && %s', expand("%:p:r"), expand("%:p"), expand("%:p:r"))
        \}
  "実行コマンド辞書に入ってたら実行キーバインドを設定
  if match(keys(g:compile_command_dict), &filetype) >= 0
    "下ウィンドウがターミナルであることを前提としている
    nnoremap <expr> <F5> '<C-w>ji<C-u>' . g:compile_command_dict[&filetype] . '<CR>'
  endif
endfunction
command! Setup call Setup()

"ファイルを開き直したときに実行コマンドを再設定
autocmd BufNewFile,BufRead * Setup
"コンパイラ言語ではインデントを4マスにする
autocmd FileType c,cpp,java,cs set shiftwidth=4 softtabstop=4
"Visual Basic .NETのファイルタイプ判別
autocmd BufNewFile,BufRead *.vb setfiletype vbnet
"C/C++を開いたときにcompile_flagsをカレントディレクトリに作る
autocmd FileType c call system(printf('cp -f ~/mylib/compile_flags_c.txt %s/compile_flags.txt', expand("%:h")))
autocmd FileType cpp call system(printf('cp -f ~/mylib/compile_flags_cpp.txt %s/compile_flags.txt', expand("%:h")))

"シンボリックリンクを開いたときに元ファイルを開き直す
"autocmd BufEnter * if findfile(expand('%')) != "" && resolve(expand('%:p')) != getcwd().'/'.expand('%') | execute ':FollowSymlink' | endif

command! FollowSymlink call s:SwitchToActualFile()
function! s:SwitchToActualFile()
  let l:fname = resolve(expand('%:p'))
  let l:pos = getpos('.')
  let l:bufname = bufname('%')
  enew
  exec 'bw '. l:bufname
  exec "e" . fname
  call setpos('.', pos)
endfunction

nnoremap <expr> <F7>a '<C-w>jiatcoder ' . g:contestname . ' a ' . expand("%:p") . '<CR>'
nnoremap <expr> <F7>b '<C-w>jiatcoder ' . g:contestname . ' b ' . expand("%:p") . '<CR>'
nnoremap <expr> <F7>c '<C-w>jiatcoder ' . g:contestname . ' c ' . expand("%:p") . '<CR>'
nnoremap <expr> <F7>d '<C-w>jiatcoder ' . g:contestname . ' d ' . expand("%:p") . '<CR>'
nnoremap <expr> <F7>e '<C-w>jiatcoder ' . g:contestname . ' e ' . expand("%:p") . '<CR>'
nnoremap <expr> <F7>f '<C-w>jiatcoder ' . g:contestname . ' f ' . expand("%:p") . '<CR>'

command! -nargs=1 Atcoder call Atcoder(<f-args>)
function! Atcoder(name)
  let g:contestname = a:name
  call system('xdg-open https://atcoder.jp/contests/' . g:contestname . '/tasks/' . g:contestname . '_a')
endfunction

command! -nargs=1 Tweet call Tweet(<f-args>)
function! Tweet(content)
  call system('tweet.sh post ' . a:content)
endfunction

"textobj-userの衝突回避---------------
omap iF <Plug>(textobj-function-i)
omap aF <Plug>(textobj-function-a)
vmap iF <Plug>(textobj-function-i)
vmap aF <Plug>(textobj-function-a)

"vim-operator-replaceの設定---------
nmap R <Plug>(operator-replace)
nmap R <Plug>(operator-replace)

"vim-operator-surroundの設定---------
nmap sa <Plug>(operator-surround-append)
nmap sd <Plug>(operator-surround-delete)
nmap sr <Plug>(operator-surround-replace)
vmap sa <Plug>(operator-surround-append)
vmap sd <Plug>(operator-surround-delete)
vmap sr <Plug>(operator-surround-replace)

"python3の場所-----------------------
let g:python_host_prog = '/bin/python2'
let g:python3_host_prog = '/bin/python3'

"open-browserの設定------------------
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"deinの設定-----------------------https://knowledge.sakura.ad.jp/23248/
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
