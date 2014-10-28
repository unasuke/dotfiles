"neobundle.vimの設定
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" install plugins
NeoBundle 'Shougo/vimproc.vim', {
	\ 'build' : {
	\	'windows' : 'make -f make_mingw32.mak',
	\	'cygwin' : 'make -f make_cygwin.mak',
	\	'mac' : 'make -f make_mac.mak',
	\	'unix' : 'make -f make_unix.mak',
	\	},
	\}

NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'itchyny/lightline.vim'
set laststatus=2
let g:lightline = {
	\ 'colorscheme' : 'solarized' ,
	\}
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

