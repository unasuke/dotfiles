set encoding=UTF-8
scriptencoding UTF-8

" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
call plug#begin()
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'lifepillar/vim-solarized8', {'branch': 'neovim'}
"Plug 'lambdalisue/fern.vim'
"Plug 'lambdalisue/fern-git-status.vim'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'wakatime/vim-wakatime'
"Plug 'airblade/vim-gitgutter'
"Plug 'vim-ruby/vim-ruby'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'hashivim/vim-terraform'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': 'v0.1.9' }
call plug#end()

set number
filetype plugin indent on
syntax on
set autoindent
set noswapfile
set nobackup
set noerrorbells
set autoread

"colorscheme setting
set t_Co=256
set background=dark
let g:solarized_termtrans=1
colorscheme solarized8_high

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

" Telescope
nnoremap <c-p> <cmd>Telescope find_files<cr>
