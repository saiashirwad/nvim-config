runtime surround.vim

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap n nzz
nnoremap N Nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>Onoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

set notermguicolors
set clipboard=unnamedplus
set nobackup noswapfile nowritebackup undofile
set number relativenumber
set expandtab shiftwidth=2 softtabstop=2 tabstop=2 ignorecase
set title
set splitbelow splitright
set smartcase

colorscheme default
let $TERM = "xterm-256color"

highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight Function ctermfg=14
highlight String ctermfg=2
highlight Boolean ctermfg=9
highlight Number ctermfg=9
highlight Keyword ctermfg=12
highlight Todo ctermfg=12
