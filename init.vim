runtime options.vim
runtime colorscheme.vim

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

nnoremap <leader>bf :!bun biome format --write %<CR>
nnoremap <leader>gc :sp ~/.config/ghostty/config <CR>

runtime coc.vim
runtime fzf.vim
