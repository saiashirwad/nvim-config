set notermguicolors
let $TERM = "xterm-256color"

set fillchars+=vert:│
set fillchars+=horiz:─
set fillchars+=horizup:┴
set fillchars+=horizdown:┬
set fillchars+=vertleft:┤
set fillchars+=vertright:├
set fillchars+=verthoriz:┼

colorscheme default

highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight VertSplit ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE ctermfg=7
highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorLineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE

highlight WinSeparator ctermbg=NONE ctermfg=8 guibg=NONE
highlight VertSplit ctermbg=NONE ctermfg=8 guibg=NONE
highlight WinBar ctermbg=NONE
highlight WinBarNC ctermbg=NONE

highlight Pmenu ctermbg=0 ctermfg=15
highlight PmenuSel ctermbg=8 ctermfg=15

highlight Search cterm=underline ctermfg=NONE ctermbg=NONE
highlight IncSearch cterm=bold,underline ctermfg=NONE ctermbg=NONE

highlight StatusLine ctermbg=0 ctermfg=15
highlight StatusLineNC ctermbg=0 ctermfg=7

highlight Visual cterm=reverse ctermbg=NONE
highlight VisualNOS cterm=reverse ctermbg=NONE

augroup TerminalColors
    autocmd!
    autocmd ColorScheme * highlight clear
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
augroup END

highlight Comment ctermfg=7
highlight Constant ctermfg=13
highlight Identifier ctermfg=11
highlight Function ctermfg=14
highlight Statement ctermfg=12
highlight Operator ctermfg=13
highlight String ctermfg=2
highlight Type ctermfg=10
highlight PreProc ctermfg=9

highlight Special ctermfg=13
highlight Boolean ctermfg=9
highlight Number ctermfg=9
highlight Structure ctermfg=10
highlight Keyword ctermfg=12
highlight Tag ctermfg=12
highlight Delimiter ctermfg=7

highlight typescriptArrowFunc ctermfg=12
highlight typescriptBraces ctermfg=7
highlight typescriptDecorator ctermfg=13
highlight typescriptDotNotation ctermfg=7
highlight typescriptEnum ctermfg=10
highlight typescriptEnumKeyword ctermfg=12
highlight typescriptExport ctermfg=12
highlight typescriptFuncKeyword ctermfg=12
highlight typescriptIdentifier ctermfg=11
highlight typescriptInterfaceKeyword ctermfg=12
highlight typescriptInterfaceName ctermfg=10
highlight typescriptInterpolationDelimiter ctermfg=13
highlight typescriptModule ctermfg=12
highlight typescriptObjectLabel ctermfg=7
highlight typescriptParens ctermfg=7
highlight typescriptPropertySignature ctermfg=7
highlight typescriptString ctermfg=2
highlight typescriptStringLiteralType ctermfg=2
highlight typescriptTemplateSB ctermfg=2
highlight typescriptTernaryOp ctermfg=13
highlight typescriptTypeAnnotation ctermfg=7
highlight typescriptTypeParameter ctermfg=10
highlight typescriptTypeReference ctermfg=10
highlight typescriptUnion ctermfg=7
highlight typescriptVariable ctermfg=11

highlight TabLine ctermfg=7 ctermbg=0
highlight TabLineSel ctermfg=15 ctermbg=8
highlight Visual ctermfg=NONE ctermbg=8
highlight MatchParen ctermfg=15 ctermbg=8
highlight Error ctermfg=9
highlight WarningMsg ctermfg=11
highlight Todo ctermfg=12

  
highlight CocErrorFloat ctermfg=9 ctermbg=0
highlight CocErrorHighlight ctermbg=NONE cterm=undercurl ctermfg=9
highlight CocFloating ctermbg=0 ctermfg=15
highlight CocHintFloat ctermfg=10 ctermbg=0
highlight CocHintHighlight ctermbg=NONE cterm=undercurl ctermfg=10
highlight CocInfoFloat ctermfg=12 ctermbg=0
highlight CocInfoHighlight ctermbg=NONE cterm=undercurl ctermfg=12
highlight CocWarningFloat ctermfg=11 ctermbg=0
highlight CocWarningHighlight ctermbg=NONE cterm=undercurl ctermfg=11
