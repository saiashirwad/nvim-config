set notermguicolors
let $TERM = "xterm-256color"

colorscheme default

" Basic UI elements
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight VertSplit ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE ctermfg=8
highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorLineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE

" Popup menu colors
highlight Pmenu ctermbg=0 ctermfg=15
highlight PmenuSel ctermbg=8 ctermfg=15

" Search highlighting
highlight Search cterm=underline ctermfg=NONE ctermbg=NONE
highlight IncSearch cterm=bold,underline ctermfg=NONE ctermbg=NONE

" Status line
highlight StatusLine ctermbg=0 ctermfg=15
highlight StatusLineNC ctermbg=0 ctermfg=7

" Visual selection
highlight Visual cterm=reverse ctermbg=NONE
highlight VisualNOS cterm=reverse ctermbg=NONE

" Auto command for ColorScheme events
augroup TerminalColors
    autocmd!
    autocmd ColorScheme * highlight clear
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
augroup END

" Syntax highlighting
highlight Comment ctermfg=8
highlight Constant ctermfg=13
highlight Identifier ctermfg=11
highlight Function ctermfg=14
highlight Statement ctermfg=12
highlight Operator ctermfg=13
highlight String ctermfg=2
highlight Type ctermfg=10
highlight PreProc ctermfg=9

" TypeScript specific highlights
highlight Special ctermfg=13
highlight Boolean ctermfg=9
highlight Number ctermfg=9
highlight Structure ctermfg=10
highlight Keyword ctermfg=12
highlight Tag ctermfg=12
highlight Delimiter ctermfg=7

" Additional UI elements
highlight TabLine ctermfg=7 ctermbg=0
highlight TabLineSel ctermfg=15 ctermbg=8
highlight Visual ctermfg=NONE ctermbg=8
highlight MatchParen ctermfg=15 ctermbg=8
highlight Error ctermfg=9
highlight WarningMsg ctermfg=11
highlight Todo ctermfg=12
