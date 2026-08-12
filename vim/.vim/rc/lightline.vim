" Shared lightline configuration, sourced from both .vimrc and
" neovim/.config/nvim/init.vim. Edit here, not in either of them.

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
