set encoding=UTF-8
scriptencoding UTF-8

set runtimepath^=~/.vim/bundle/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/bundle'))
call dein#add('airblade/vim-gitgutter')
call dein#add('altercation/vim-colors-solarized')
call dein#add('ap/vim-css-color')
call dein#add('chr4/nginx.vim')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('fatih/vim-go')
call dein#add('haya14busa/incsearch.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('jiangmiao/auto-pairs')
call dein#add('mrk21/yaml-vim')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('osyo-manga/shabadou.vim')
call dein#add('othree/html5.vim')
call dein#add('othree/yajs.vim')
call dein#add('prabirshrestha/async.vim')
call dein#add('prabirshrestha/vim-lsp')
"call dein#add('pocke/iro.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('sjl/gundo.vim')
call dein#add('slim-template/vim-slim')
call dein#add('thinca/vim-quickrun')
call dein#add('tmux-plugins/vim-tmux')
call dein#add('tpope/vim-fugitive')
"call dein#add('tpope/vim-haml')
call dein#add('tpope/vim-rails')
call dein#add('vim-jp/vimdoc-ja')
"call dein#add('vim-ruby/vim-ruby')
call dein#add('w0ng/vim-hybrid')
call dein#add('w0rp/ale')
call dein#add('wakatime/vim-wakatime')
call dein#add('Xuyuanp/nerdtree-git-plugin')

call dein#end()

"help language use Japanese
set helplang=ja,en

"vimを使ってくれてありがとう!!!!!!!!!!
set notitle

"Ricty(only gvim?)
set guifont=Ricty:h16

"syntax
syntax on

"line number
set number

"indent setting
filetype plugin indent on
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set breakindent

"no more swapfile
set noswapfile
set nobackup

"status line setting
set laststatus=2
let g:lightline = {
  \ 'colorscheme' : 'solarized' ,
  \ 'active' : {
  \   'left' : [['mode', 'paste'], ['fugitive', 'filename', 'modified']]
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

let g:vimshell_force_overwrite_statusline= 0
autocmd CursorMoved ControlP let w:lightline = 0

"convert file encode
function! SetUU()
  set ff=unix
  set fenc=utf8
endfunction
command -nargs=0 SetUU call SetUU()

"use backspace
set backspace=indent,eol,start

"Neocomplete
"source ~/.neocomplete.vim

"NerdTree
source ~/.nerdtree.vim

"vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 2
let g:indent_guides_auto_colors = 1
"hi IndentGuidesOdd ctermbg=grey
"hi IndentGuidesEven ctermbg=darkgrendent_guides_start_level = 2
"let g:indent_guides_indent_levels = 10
"
"let g:indent_guides_guide_size = 1
"let g:indent_guides_auto_colors = 0
"hi IndentGuidesOdd ctermbg=grey
"hi IndentGuidesEven ctermbg=darkgrey


"tabs
nnoremap <silent> <Space>j :tabnext<CR>
nnoremap <silent> <Space>l :tabprevious<CR>
nnoremap <silent> <Space>t :tabedit<CR>

nmap ; :

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
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:gitgutter_max_signs = 1000

" I don't use octal
set nrformats-=octal

" NO BEEPS!!!!!!!!!!!!!!!!!!!!!!!!!
set noerrorbells
set vb t_vb=

set virtualedit+=block

"set updatetime=10

set signcolumn=yes

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "*",
    \ "Untracked" : "*",
    \ "Renamed"   : "*",
    \ "Unmerged"  : "*",
    \ "Deleted"   : "*",
    \ "Dirty"     : "*",
    \ "Clean"     : "*",
    \ "Unknown"   : "*"
    \ }

" highlight cursor position
set cursorline
augroup CursorLineOnlyCurrentWindow
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END
set lazyredraw
set ttyfast

" enable syntax check
let g:watchdogs_check_BufWritePost_enable = 1

setlocal iskeyword+=-

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" check not install plugin
if dein#check_install()
  call dein#install()
endif

" ambigous character
set ambiwidth=double

" command completion
set wildmode=list:full

nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"colorscheme setting
set t_Co=256
set background=dark
let g:solarized_termtrans=1
colorscheme solarized

if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

if executable('gopls')
  augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-lang',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
  augroup END
endif

let g:lsp_diagnostics_enabled = 0
