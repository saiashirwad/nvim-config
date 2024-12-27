set notermguicolors
let $TERM = "xterm-256color"

colorscheme default

" Basic UI elements
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight VertSplit ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorLineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE

" Popup menu colors
highlight Pmenu ctermbg=0 ctermfg=15
highlight PmenuSel ctermbg=8 ctermfg=15

" Search highlighting
highlight Search cterm=underline ctermfg=NONE ctermbg=NONE
highlight IncSearch cterm=underline ctermfg=NONE ctermbg=NONE

" Status line
highlight StatusLine ctermbg=0 ctermfg=15
highlight StatusLineNC ctermbg=0 ctermfg=7

" Search and selection
highlight Search cterm=underline ctermfg=NONE ctermbg=NONE
highlight IncSearch cterm=bold,underline ctermfg=NONE ctermbg=NONE
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
highlight @comment ctermfg=8
highlight @constant ctermfg=13
highlight @field ctermfg=11
highlight @function ctermfg=14
highlight @keyword ctermfg=12
highlight @method ctermfg=14
highlight @operator ctermfg=13
highlight @parameter ctermfg=11
highlight @property ctermfg=11
highlight @string ctermfg=2
highlight @type ctermfg=10
highlight @variable ctermfg=7

highlight LineNr ctermfg=8

" TypeScript specific highlights
highlight @constructor ctermfg=14
highlight @namespace ctermfg=12
highlight @decorator ctermfg=13
highlight @boolean ctermfg=9
highlight @number ctermfg=9
highlight @type.builtin ctermfg=10
highlight @variable.builtin ctermfg=9
highlight @punctuation ctermfg=7
highlight @tag ctermfg=12
highlight @tag.attribute ctermfg=11
highlight @text.literal ctermfg=7
highlight @type.qualifier ctermfg=12

" Additional UI elements
highlight TabLine ctermfg=7 ctermbg=0
highlight TabLineSel ctermfg=15 ctermbg=8
highlight Visual ctermfg=NONE ctermbg=8
highlight MatchParen ctermfg=15 ctermbg=8
highlight DiagnosticError ctermfg=9
highlight DiagnosticWarn ctermfg=11
highlight DiagnosticInfo ctermfg=12
highlight DiagnosticHint ctermfg=14

" Telescope highlights
highlight TelescopePromptTitle ctermfg=14 ctermbg=NONE
highlight TelescopePromptBorder ctermfg=8 ctermbg=NONE
highlight TelescopePromptNormal ctermfg=7 ctermbg=NONE
highlight TelescopeResultsNormal ctermfg=7 ctermbg=NONE
highlight TelescopeSelection ctermfg=15 ctermbg=8
highlight TelescopePreviewTitle ctermfg=14 ctermbg=NONE
highlight TelescopePreviewBorder ctermfg=8 ctermbg=NONE
