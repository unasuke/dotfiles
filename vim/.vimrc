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
NeoBundle 'slim-template/vim-slim'
NeoBundle 'scrooloose/nerdtree' 
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'kchmck/vim-coffee-script'

call neobundle#end()
NeoBundleCheck

"help language use Japanese
set helplang=ja,en

"vimを使ってくれてありがとう!!!!!!!!!!
set notitle

"Ricty(only gvim?)
set guifont=Ricty:h16

"use UTF-8
set encoding=UTF-8

"syntax
syntax on

"line number
set number

"indent setting
filetype plugin indent on
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

"no more swapfile
set noswapfile
set nobackup

"status line setting
set laststatus=2
let g:lightline = {
  \ 'colorscheme' : 'solarized' ,
  \ 'mode_map' : {'c': 'NORMAL'},
  \ 'active' : {
  \   'left' : [['mode', 'paste'], ['fugitive', 'filename']]
  \ },
  \ 'conponent_function' : {
  \   'modified' : 'MyModified',
  \   'readonly' : 'MyReadonly',
  \   'fugitive' : 'MyFugitive',
  \   'filename' : 'MyFilename',
  \   'fileformat' : 'MyFileformat',
  \   'filetype' : 'MyFiletype',
  \   'fileencoding' : 'MyFileencoding',
  \   'mode' : 'MyMode'
  \ }
  \ }

"colorscheme setting
set t_Co=256
set background=dark
colorscheme solarized

"convert file encode
function! SetUU()
  set ff=unix
  set fenc=utf8
endfunction
command -nargs=0 SetUU call SetUU()

"use backspace
set backspace=indent,eol,start

"Neocomplete
source ~/.neocomplete.vim

"NerdTree
source ~/.nerdtree.vim

"vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

let g:indent_guides_start_level = 2
let g:indent_guides_indent_levels = 10

let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 1
"hi IndentGuidesOdd ctermbg=grey
"hi IndentGuidesEven ctermbg=darkgrendent_guides_start_level = 2
"let g:indent_guides_indent_levels = 10
"
"let g:indent_guides_guide_size = 1
"let g:indent_guides_auto_colors = 0
"hi IndentGuidesOdd ctermbg=grey
"hi IndentGuidesEven ctermbg=darkgrey

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let branch = fugitive#head()
      return strlen(branch) ? branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
