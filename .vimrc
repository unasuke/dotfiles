"neobundle.vimの設定
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

"install plugins
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
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'wakatime/vim-wakatime'

call neobundle#end()
NeoBundleCheck

"help language use Japanese
set helplang=ja,en

"vimを使ってくれてありがとう!!!!!!!!!!
set notitle

"Ricty
set guifont=Ricty\ 11

"use UTF-8
set encoding=UTF-8

"syntax
syntax on

"line number
set number

"indent setting
set autoindent
set smartindent
filetype plugin indent on

"no more swapfile
set noswapfile
set nobackup

"status line setting
set laststatus=2
let g:lightline = {
	\ 'colorscheme' : 'solarized' ,
	\}

"colorscheme setting
set t_Co=256
set background=dark
colorscheme solarized

"convert file encode
function SetUU()
	set ff=unix
	set fenc=utf8
endfunction
command -nargs=0 SetUU call SetUU()

"use backspace
set backspace=indent,eol,start
