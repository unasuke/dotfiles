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
set iskeyword+=-
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
  set clipboard^=unnamed,autoselect
endif

"incsearch
set incsearch
set hlsearch

" lightline (shared with neovim; see ~/.vim/rc/lightline.vim)
if filereadable(expand('~/.vim/rc/lightline.vim'))
  source ~/.vim/rc/lightline.vim
endif

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
