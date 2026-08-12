set encoding=UTF-8
scriptencoding UTF-8

" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
call plug#begin()
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'lifepillar/vim-solarized8', {'branch': 'neovim'}
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'wakatime/vim-wakatime'
Plug 'airblade/vim-gitgutter'
"Plug 'vim-ruby/vim-ruby'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'hashivim/vim-terraform'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': 'v0.1.9' }
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

set number
filetype plugin indent on
syntax on
set autoindent
set noswapfile
set nobackup
set noerrorbells
set autoread
set shiftwidth=2
set tabstop=2
set softtabstop=2
nmap ; :

"colorscheme setting
set t_Co=256
set background=dark
let g:solarized_termtrans=1
colorscheme solarized8_high

" lightline (shared with neovim; see ~/.vim/rc/lightline.vim)
if filereadable(expand('~/.vim/rc/lightline.vim'))
  source ~/.vim/rc/lightline.vim
endif

" Telescope
nnoremap <c-p> <cmd>Telescope find_files<cr>

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

" tabs
nnoremap <silent> <Space>j :tabnext<CR>
nnoremap <silent> <Space>l :tabprevious<CR>
nnoremap <silent> <Space>t :tabedit<CR>

" incsearch
set incsearch
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" auto reload
augroup AutoRead
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold * checktime
augroup END

" tree-sitter
lua <<EOF
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(ctx)
      if not pcall(vim.treesitter.start) then return end
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
EOF
