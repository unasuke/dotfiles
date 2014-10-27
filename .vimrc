"neobundle.vimの設定
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

"非同期処理
NeoBundle 'Shougo/vimproc.vim', {
	\ 'build' : {
	\	'windows' : 'make -f make_mingw32.mak',
	\	'cygwin' : 'make -f make_cygwin.mak',
	\	'mac' : 'make -f make_mac.mak',
	\	'unix' : 'make -f make_unix.mak',
	\	},
	\}

"すごいunite
NeoBundle 'Shougo/unite.vim'

"プログラムの簡易実行結果
NeoBundle 'thinca/vim-quickrun'

"solarized
NeoBundle 'altercation/vim-colors-solarized'
"set t_Co=256
"set background=dark
"colorscheme solarized

"補完
NeoBundle 'Shougo/neocomplete.vim'

"lightline
NeoBundle 'itchyny/lightline.vim'
set laststatus=2
let g:lightline = {
	\ 'colorscheme' : 'solarized' ,
	\}

"日本語ドキュメント
NeoBundle 'vim-jp/vimdoc-ja'
set helplang=ja,en

"Vimを使ってくれてありがとう!!!!!!!!!!
set notitle

"Ricty
set guifont=Ricty\ 11

"国際化isじゅうよう
set encoding=UTF-8

"syntax
syntax on

"行番号
set number

"インデント
set autoindent
set smartindent
filetype plugin indent on

"no more swapfile
set noswapfile
set nobackup

call neobundle#end()
NeoBundleCheck

"colorscheme setting moved here
set t_Co=256
set background=dark
colorscheme solarized

