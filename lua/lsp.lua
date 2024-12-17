vim.diagnostic.config({
	underline = false,
	update_in_insert = false,
	severity_sort = false,
	signs = false,
	virtual_text = {
		format = function(diagnostic)
			if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
				return ""
			end
			return diagnostic.message
		end,
	},
})

vim.notify = function(msg, level, opts)
	if msg:match("Debug Failure") or msg:match("False expression") then
		return
	end
end

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

vim.diagnostic.config({
	float = {
		border = border,
		style = "full",
		source = "always",
	},
})

local organize_imports = function()
	local params = {
		command = "typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end
