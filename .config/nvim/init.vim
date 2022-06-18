"行番号を表示
set number
"タブ文字の代わりにスペースを使う
set expandtab
"プログラミング言語に合わせて適切にインデントを自動挿入
set smartindent
"各コマンドやsmartindentで挿入する空白の量
set shiftwidth=4
"Tabキーで挿入するスペースの数
set softtabstop=4
"バッファ内で扱う文字コード
set encoding=utf-8
"読み込む文字列 : この場合UTF-8を試し、だめならShift_JIS
set fileencodings=utf-8,cp932
"eコマンド等でTabキーを押すとパスを保管する : この場合まず最長一致文字列まで保管し、2回目以降は一つづつ試す
set wildmode=longest,full
"未保存ファイルが有っても別のファイルを開く
set hidden
"マウスでカーソル移動したりビジュアルモードに入る
set mouse=nv
"F2でペーストモードをトグルする
set pastetoggle=<F2>

"LeaderキーをSpaceに設定(これだけでは意味をなさない)
let mapleader = "\<Space>"

"jj
inoremap jj <Esc>
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

"Ctrl+SpaceをVimに渡さない
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

"上のエディタウィンドウと下のターミナルウィンドウ(ターミナル挿入モード)を行き来
tnoremap <C-t> <C-\><C-n><C-w>k
nnoremap <C-t> <C-w>ji
"ターミナル挿入モードからターミナルモードへ以降
tnoremap <Esc> <C-\><C-n>

"クリップボード連携
if system('uname -a | grep microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
elseif system('uname -a | grep Darwin') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('pbcopy', @")
  augroup END
else
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('xclip -selection clipboard', @")
  augroup END
endif

"pythonとRubyの場所-----------------------
let g:python_host_prog = system('echo -n $(which python2)')
let g:python3_host_prog = system('echo -n $(which python3)')
let g:ruby_host_prog = system('echo -n $(which neovim-ruby-host)')

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
  "call dein#load_toml(s:lazy_toml, {'lazy' : 1})

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

"何故かこれがないとhookされなくなった
call dein#call_hook('source')

"dein#end()よりあとにcolorschemeを指定する必要があるらしい
if dein#is_available('vim-hybrid')
  "ターミナルの背景画像を使う
  autocmd ColorScheme * highlight Normal ctermbg=none
  autocmd ColorScheme * highlight LineNr ctermbg=none
  colorscheme hybrid
end

"commands.vimがあれば読み込む
if filereadable('commands.vim')
  source commands.vim
end
