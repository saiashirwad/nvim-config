require("bootstrap")
require("options")
require("colors")

local organize_imports = function()
	local params = {
		command = "typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

require("lazy").setup({
	"tpope/vim-sleuth",
	"marilari88/twoslash-queries.nvim",
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			lsp = {},
			mappings = true,
		},
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
	},

	{
		"sindrets/diffview.nvim",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<CR>")
			vim.keymap.set("n", "<leader>dO", "<cmd>DiffviewClose<CR>")
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},

	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	{
		"nvim-pack/nvim-spectre",
		lazy = false,
		event = "BufRead",
		opts = {},
		keys = { { "<leader>sr", "<cmd>Spectre<CR>" } },
	},

	{ "duane9/nvim-rg" },

	{
		"stevearc/oil.nvim",
		opts = {
			view_options = { show_hidden = true, icons = false },
			float = { padding = 0, max_width = 30, max_height = 30 },
		},
		keys = function()
			local oil = require("oil")
			return {
				{ "<C-f><C-o>", oil.open },
				{ "<leader>fo", oil.open_float },
			}
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>")
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				typescript = { "biomejs" },
				typescriptreact = { "biomejs" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					sorting_strategy = "ascending",
					border = true,
					prompt_prefix = "🔍 ",
					selection_caret = "➜ ",
					entry_prefix = "  ",
					results_title = false,
					borderchars = {
						prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
						results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
						preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					},
					color_devicons = true,
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_ivy({
							borderchars = {
								preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
							},
						}),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")

			local find_files_in_dotfiles = function()
				builtin.find_files({ search_dirs = { "~/dotfiles" }, hidden = true })
			end

			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>fv", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
			vim.keymap.set("n", "<leader>fc", find_files_in_dotfiles, { desc = "[S]earch dotfiles" })
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{ "Bilal2453/luvit-meta", lazy = true },

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			-- "hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local function setup_keymaps(bufnr)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			end

			local function setup_highlight(client, bufnr)
				if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event.buf })
						end,
					})
				end
			end

			local function setup_inlay_hints(client, bufnr)
				if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					vim.keymap.set("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
					end, { buffer = bufnr, desc = "[T]oggle Inlay [H]ints" })
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					setup_keymaps(bufnr)
					setup_highlight(client, bufnr)
					setup_inlay_hints(client, bufnr)
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				vtsls = {
					commands = {
						OrganizeImports = {
							organize_imports,
						},
					},
				},
			}

			local server_names = {
				"html",
				"cssls",
				"jsonls",
			}

			for _, name in ipairs(server_names) do
				servers[name] = servers[name] or {}
			end

			require("lspconfig").nelua_lsp.setup({
				cmd = {
					"nelua",
					"-L",
					"~/repos/nelua-lsp/nelua-lsp.lua",
					"--script",
					"~/repos/nelua-lsp/nelua-lsp.lua",
				},
			})

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { "stylua" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				prisma = { "prisma" },
				python = { "black" },
				haskell = { "fourmolu" },
				ocaml = { "ocamlformat" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				elm = { "elm-format" },
				rust = { "rustfmt" },
				purescript = { "purty" },
				clojure = { "cljstyle" },
				clojuredart = { "cljstyle" },
				cljd = { "cljstyle" },
				fennel = { "fnlfmt" },
				dart = { "dart_format" },
				rescript = { "rescript" },
				zig = { "zig" },
			},
			formatters = {
				prisma = {
					command = "pnpm prisma format",
				},
			},
		},
	},

	{
		"ms-jpq/coq_nvim",
		branch = "coq",
		event = "InsertEnter",
		dependencies = {
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
		config = function()
			vim.g.coq_settings = {
				auto_start = false,
				keymap = {
					jump_to_mark = "<C-l>",
					pre_select = true,
					recommended = false,
					manual_complete = "<C-Space>",
					bigger_preview = "<C-b>",
					manual_complete_insertion_only = true,
				},
				clients = {
					snippets = {
						enabled = true,
						warn = {},
					},
					tree_sitter = {
						enabled = true,
						weight_adjust = 1.0,
					},
					tags = { enabled = true },
					buffers = { enabled = true },
				},
			}

			vim.cmd("COQnow -s")

			local remap = vim.api.nvim_set_keymap
			local npairs = require("nvim-autopairs")

			npairs.setup({ map_bs = false, map_cr = false })

			-- These mappings are coq recommended mappings unrelated to nvim-autopairs
			remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
			remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
			remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
			remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

			-- skip it, if you use another global object
			_G.MiniPairs = {}

			MiniPairs.cr = function()
				if vim.fn.pumvisible() ~= 0 then
					if vim.fn.complete_info({ "selected" }).selected ~= -1 then
						return npairs.esc("<c-y>")
					else
						return npairs.esc("<c-e>") .. npairs.autopairs_cr()
					end
				else
					return npairs.autopairs_cr()
				end
			end
			remap("i", "<cr>", "v:lua.MiniPairs.cr()", { expr = true, noremap = true })

			MiniPairs.bs = function()
				if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
					return npairs.esc("<c-e>") .. npairs.autopairs_bs()
				else
					return npairs.autopairs_bs()
				end
			end
			remap("i", "<bs>", "v:lua.MiniPairs.bs()", { expr = true, noremap = true })
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"alexghergh/nvim-tmux-navigation",
		opts = {},
		keys = function()
			local nvim_tmux_nav = require("nvim-tmux-navigation")
			return {
				{ "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = "Navigate Left" } },
				{ "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, { desc = "Navigate Down" } },
				{ "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = "Navigate Up" } },
				{ "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { desc = "Navigate Right" } },
				{ "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive, { desc = "Navigate Last Active" } },
				{ "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext, { desc = "Navigate Next" } },
			}
		end,
	},

	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			folding = { enable = false },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = false, disable = { "ruby" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
		},
	},

	{
		"LintaoAmons/cd-project.nvim",
		tag = "v0.6.1",
		lazy = false,
		keys = { { "<leader>cd", "<cmd>CdProject<CR>" } },
		config = function()
			require("cd-project").setup({
				projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/cd-project.nvim.json"),
				project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
				choice_format = "both",
				projects_picker = "vim-ui",
				auto_register_project = false,
				hooks = {
					{
						callback = function(dir)
							vim.notify("switched to dir: " .. dir)
						end,
					},
					{
						callback = function(_)
							vim.cmd("Telescope find_files")
						end,
					},
					{
						callback = function(dir)
							vim.notify("switched to dir: " .. dir)
						end,
						name = "cd hint",
						order = 1,
						pattern = "cd-project.nvim",
						trigger_point = "DISABLE",
						match_rule = function(dir)
							return true
						end,
					},
				},
			})
		end,
	},
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

if os.getenv("TERM") == "xterm-kitty" then
	vim.g.kitty_navigator_no_mappings = 1
	vim.g.tmux_navigator_no_mappings = 1

	vim.api.nvim_set_keymap("n", "C-h", ":KittyNavigateLeft <CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "C-j", ":KittyNavigateDown <CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "C-k", ":KittyNavigateUp <CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "C-l", ":KittyNavigateRight <CR>", { noremap = true, silent = true })
end

vim.diagnostic.config({
	virtual_text = false,
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
