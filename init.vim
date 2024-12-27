runtime options.vim
runtime colorscheme.vim

call plug#begin()
Plug 'folke/flash.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap n nzz
nnoremap N Nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap <leader>bf :!bun biome format --write %<CR>
nnoremap <leader>gc :sp ~/.config/ghostty/config <CR>
nnoremap <leader>rc :e $MYVIMRC<CR>

runtime coc.vim
runtime fzf.vim
