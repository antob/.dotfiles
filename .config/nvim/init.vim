call plug#begin()

" General
Plug 'tpope/vim-sensible'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'mcchrish/nnn.vim'

call plug#end()

" Colors
colorscheme onedark

" Load general config
for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
  exe 'source' f
endfor

" Load plugin config
for f in split(glob('~/.config/nvim/config/plugin/*.vim'), '\n')
  exe 'source' f
endfor

