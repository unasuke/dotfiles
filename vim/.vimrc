set encoding=UTF-8
scriptencoding UTF-8


" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wakatime/vim-wakatime'
Plug 'airblade/vim-gitgutter'
Plug 'vim-ruby/vim-ruby'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'hashivim/vim-terraform'
call plug#end()

syntax on
filetype plugin indent on
set helplang=ja,en
set notitle
set number
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set breakindent
set noswapfile
set nobackup
set noerrorbells
set vb t_vb=
set virtualedit+=block
set signcolumn=yes
set backspace=indent,eol,start
set ambiwidth=double
set wildmode=list:full
set nrformats-=octal
setlocal iskeyword+=-
set autoread

"tabs
nnoremap <silent> <Space>j :tabnext<CR>
nnoremap <silent> <Space>l :tabprevious<CR>
nnoremap <silent> <Space>t :tabedit<CR>
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

nmap ; :

" highlight cursor position
set cursorline
augroup CursorLineOnlyCurrentWindow
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END
set lazyredraw
set ttyfast

if has("mac")
  set clipboard&
  set clipboard+=unnamed
elseif has("unix")
  set clipboard&
  set clipboard^=unnamedplus
else
  set clipboard&
  set clipboard=^unnamed,autoselect
endif

"incsearch
set incsearch
set hlsearch

" lightline
set laststatus=2
let g:lightline = {
  \ 'colorscheme' : 'solarized' ,
  \ 'active' : {
  \   'left' : [['mode', 'paste'], ['filename', 'modified']]
  \ },
  \ 'component_function' : {
  \   'modified' : 'LightLineModified',
  \   'readonly' : 'LightLineReadonly',
  \   'fugitive' : 'LightLineFugitive',
  \   'filename' : 'LightLineFilename',
  \   'fileformat' : 'LightLineFileformat',
  \   'filetype' : 'LightLineFiletype',
  \   'fileencoding' : 'LightLineFileencoding',
  \   'mode' : 'LightLineMode'
  \ }
  \ }

function! LightLineModified()
  return &ft =~ 'help\|nerdtree\|undotree\|vimfiler\|gundo\|diff\|qf' ? '': @% == '[YankRing]' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|nerdtree\|undotree\|vimfiler\|gundo\|diff' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return &ft == 'nerdtree' ? 'NERDTree' :
       \ &ft == 'undotree' ? 'undotree' :
       \ &ft == 'diff' ? 'diffpanel' :
       \ &ft == 'qf' ? 'Quickfix' :
       \ &ft == 'vimshell' ? vimshell#get_status_string() :
       \ @% == '[YankRing]' ? 'YankRing' :
       \ &ft == 'unite' ? unite#get_status_string() :
       \ ('' != @% ? @% : '[No Name]') .
       \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  "let filename = expand('%:t')
  if &ft !~? 'help\|nerdtree\|undotree\|quickrun\|vimfiler\|gundo\|qf' && @% != '[YankRing]' && exists("*fugitive#head")
    let branch = fugitive#head()
    return strlen(branch) ? branch : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return &ft == 'qf' ? '' :
       \ @% == '[YankRing]' ? '' :
       \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" end lightline

let g:vimshell_force_overwrite_statusline= 0
autocmd CursorMoved ControlP let w:lightline = 0

"convert file encode
function! SetUU()
  set ff=unix
  set fenc=utf8
endfunction
command -nargs=0 SetUU call SetUU()


" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_match_window = 'min:5,max:25'

"colorscheme setting
set t_Co=256
set background=dark
let g:solarized_termtrans=1
colorscheme solarized8_high

" fern
let g:fern#default_hidden=1
nmap <silent> <space>e :Fern . -drawer -toggle<CR>

function! s:init_fern() abort
  setlocal nonumber
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup end

" indent-guide
let g:indent_guides_enable_on_vim_startup = 1
