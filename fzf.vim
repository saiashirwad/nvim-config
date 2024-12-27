let g:fzf_vim = {}

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>fw :Rg<CR>
