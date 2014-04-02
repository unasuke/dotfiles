"互換モード無効
set nocompatible

"しんたっくす
syntax on

"行番号
set number

"インデント
set autoindent
set smartindent
filetype plugin indent on

"swapファイルを作らない
set noswapfile
set nobackup

"国際化isじゅうよう
set encoding=UTF-8

"neobundle.vimの設定
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

"非同期処理
NeoBundle 'Shougo/vimproc', {
	\ 'build' : {
	\	'windows' : 'make -f make_mingw32.mak',
	\	'cygwin' : 'make -f make_cygwin.mak',
	\	'mac' : 'make -f make_mac.mak'
	\	'unix' : 'make -f make_unix.mak'
	\	},
	\}

"すごいunite
NeoBundle 'Shougo/unite.vim'

"プログラムの簡易実行結果
NeoBundle 'thinca/vim-quickrun'

"solarized
NeoBundle 'altercation/vim-colors-solarized'
set t_Co=256
set background=dark
colorscheme solarized

"補完
NeoBundle 'Shougo/neocomplete.vim'

"lightline
NeoBundle 'itchyny/lightline.vim'
set laststatus=2
let g:lightline = {
	\ 'colorscheme' : 'solarized' ,
	\}

"Vimを使ってくれてありがとう!!!!!!!!!!
set notitle

"Ricty
set guifont=Ricty\ 11
