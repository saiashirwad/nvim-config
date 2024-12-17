vim.opt.termguicolors = false
vim.env.TERM = "xterm-256color"

vim.cmd("colorscheme default")

vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
vim.cmd("highlight NonText ctermbg=NONE guibg=NONE")

vim.cmd("highlight SignColumn ctermbg=NONE guibg=NONE")
vim.cmd("highlight VertSplit ctermbg=NONE guibg=NONE")
vim.cmd("highlight LineNr ctermbg=NONE guibg=NONE")
vim.cmd("highlight CursorLine ctermbg=NONE guibg=NONE")
vim.cmd("highlight CursorLineNr ctermbg=NONE guibg=NONE")
vim.cmd("highlight Folded ctermbg=NONE guibg=NONE")

-- Make popup menus cleaner
vim.cmd("highlight Pmenu ctermbg=0 ctermfg=15")
vim.cmd("highlight PmenuSel ctermbg=8 ctermfg=15")

-- Make search highlighting less aggressive
vim.cmd("highlight Search cterm=underline ctermfg=NONE ctermbg=NONE")
vim.cmd("highlight IncSearch cterm=underline ctermfg=NONE ctermbg=NONE")

-- Status line colors
vim.cmd("highlight StatusLine ctermbg=0 ctermfg=15")
vim.cmd("highlight StatusLineNC ctermbg=0 ctermfg=7")

vim.cmd("highlight Search cterm=underline ctermfg=NONE ctermbg=NONE")
vim.cmd("highlight IncSearch cterm=bold,underline ctermfg=NONE ctermbg=NONE")

-- Make popup menus use terminal colors
vim.cmd("highlight Pmenu ctermfg=7 ctermbg=0")
vim.cmd("highlight PmenuSel ctermfg=15 ctermbg=8")

-- Make selection visible but not black
vim.cmd("highlight Visual cterm=reverse ctermbg=NONE")
vim.cmd("highlight VisualNOS cterm=reverse ctermbg=NONE")

-- -- Make split borders subtle
-- vim.cmd("highlight WinSeparator ctermbg=NONE ctermfg=8")

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Reset all highlights to use terminal colors
		vim.cmd("highlight clear")
		-- Reapply terminal-based highlights
		vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
		vim.cmd("highlight NonText ctermbg=NONE guibg=NONE")
	end,
})

vim.cmd("highlight @comment ctermfg=8") -- gray
vim.cmd("highlight @constant ctermfg=13") -- bright magenta
vim.cmd("highlight @field ctermfg=11") -- bright yellow
vim.cmd("highlight @function ctermfg=14") -- bright cyan
vim.cmd("highlight @keyword ctermfg=12") -- bright blue
vim.cmd("highlight @method ctermfg=14") -- bright cyan
vim.cmd("highlight @operator ctermfg=13") -- bright magenta
vim.cmd("highlight @parameter ctermfg=11") -- bright yellow
vim.cmd("highlight @property ctermfg=11") -- bright yellow
vim.cmd("highlight @string ctermfg=2") -- green (changed from bright red)
vim.cmd("highlight @type ctermfg=10") -- bright green
vim.cmd("highlight @variable ctermfg=7") -- white

vim.cmd("highlight LineNr ctermfg=8") -- gray (dim) line numbers

-- TypeScript specific highlights
vim.cmd("highlight @constructor ctermfg=14") -- bright cyan for constructors
vim.cmd("highlight @namespace ctermfg=12") -- bright blue for namespaces
vim.cmd("highlight @decorator ctermfg=13") -- bright magenta for decorators
vim.cmd("highlight @boolean ctermfg=9") -- bright red for booleans
vim.cmd("highlight @number ctermfg=9") -- bright red for numbers
vim.cmd("highlight @type.builtin ctermfg=10") -- bright green for built-in types
vim.cmd("highlight @variable.builtin ctermfg=9") -- bright red for built-in variables
vim.cmd("highlight @punctuation ctermfg=7") -- white for brackets/punctuation
vim.cmd("highlight @tag ctermfg=12") -- bright blue for JSX tags
vim.cmd("highlight @tag.attribute ctermfg=11") -- bright yellow for JSX attributes
vim.cmd("highlight @text.literal ctermfg=7") -- white for template literals
vim.cmd("highlight @type.qualifier ctermfg=12") -- bright blue for type modifiers

-- Additional UI elements
vim.cmd("highlight TabLine ctermfg=7 ctermbg=0")
vim.cmd("highlight TabLineSel ctermfg=15 ctermbg=8")
vim.cmd("highlight Visual ctermfg=NONE ctermbg=8")
vim.cmd("highlight MatchParen ctermfg=15 ctermbg=8")
vim.cmd("highlight DiagnosticError ctermfg=9")
vim.cmd("highlight DiagnosticWarn ctermfg=11")
vim.cmd("highlight DiagnosticInfo ctermfg=12")
vim.cmd("highlight DiagnosticHint ctermfg=14")

vim.cmd("highlight TelescopePromptTitle ctermfg=14 ctermbg=NONE")
vim.cmd("highlight TelescopePromptBorder ctermfg=8 ctermbg=NONE")
vim.cmd("highlight TelescopePromptNormal ctermfg=7 ctermbg=NONE")
vim.cmd("highlight TelescopeResultsNormal ctermfg=7 ctermbg=NONE")
vim.cmd("highlight TelescopeSelection ctermfg=15 ctermbg=8")
vim.cmd("highlight TelescopePreviewTitle ctermfg=14 ctermbg=NONE")
vim.cmd("highlight TelescopePreviewBorder ctermfg=8 ctermbg=NONE")
