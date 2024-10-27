require("bootstrap")
require("options")

local organize_imports = function()
	local params = {
		command = "typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

require("lazy").setup({
	"tpope/vim-sleuth",
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "scala", "sbt", "java" },
		opts = function()
			local metals_config = require("metals").bare_config()
			metals_config.on_attach = function(client, bufnr) end

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},

	{ "marilari88/twoslash-queries.nvim" },

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
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	{
		"zenbones-theme/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.zenbones_darken_comments = 45
			-- vim.cmd.colorscheme("zenburned")
			vim.cmd.colorscheme("kanagawabones")
			-- vim.cmd.colorscheme("vimbones")
		end,
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
		opts = {

			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = true, -- Auto close on trailing </
			},
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		},
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
		keys = {
			{ "<leader>sr", "<cmd>Spectre<CR>" },
		},
	},
	{ "duane9/nvim-rg" },
	{
		"stevearc/oil.nvim",
		opts = {
			view_options = {
				show_hidden = true,
				icons = false,
			},
			float = {
				padding = 0,
				max_width = 30,
				max_height = 30,
			},
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
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
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
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
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
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					--
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				vtsls = {
					commands = {
						OrganizeImports = {
							organize_imports,
						},
					},
				},
			}

			-- require("lspconfig")["tsserver"].setup({
			-- 	on_attach = function(client, bufnr)
			-- 		require("twoslash-queries").attach(client, bufnr)
			-- 	end,
			-- })

			local server_names = {
				"html",
				"cssls",
				-- "prismals",
				-- "svelte",
				"jsonls",
				-- "astro",
				-- "purescriptls",
				-- "hls",
				-- "rescriptls",
			}

			for _, name in ipairs(server_names) do
				servers[name] = servers[name] or {}
			end

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
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
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {},
			},
			"saadparwaiz1/cmp_luasnip",

			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				--
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),

					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<C-Space>"] = cmp.mapping.complete({}),

					--
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{
						name = "lazydev",
						group_index = 0,
					},
					{ name = "nvim_lsp", max_item_count = 8 },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000, -- Make sure to load this before all the other start plugins.
	-- 	init = function()
	-- 		vim.cmd.colorscheme("tokyonight-night")
	--
	-- 		vim.cmd.hi("Comment gui=none")
	-- 	end,
	-- },

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

			-- local statusline = require("mini.statusline")
			-- statusline.setup({ use_icons = vim.g.have_nerd_font })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
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
		keys = {
			{ "<leader>cd", "<cmd>CdProject<CR>" },
		},
		config = function()
			require("cd-project").setup({
				projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/cd-project.nvim.json"),
				project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
				choice_format = "both", -- optional, you can switch to "name" or "path"
				projects_picker = "vim-ui", -- optional, you can switch to `telescope`
				auto_register_project = false, -- optional, toggle on/off the auto add project behaviour
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
						end, -- required, action when trigger the hook
						name = "cd hint", -- optional
						order = 1, -- optional, the exection order if there're multiple hooks to be trigger at one point
						pattern = "cd-project.nvim", -- optional, trigger hook if contains pattern
						trigger_point = "DISABLE", -- optional, enum of trigger_points, default to `AFTER_CD`
						match_rule = function(dir) -- optional, a function return bool. if have this fields, then pattern will be ignored
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

-- vim.diagnostic.config({
--   virtual_text = false,
--   -- Or disable only for typescript files
--   virtual_text = {
--     format = function(diagnostic)
--       if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
--         return ""
--       end
--       return diagnostic.message
--     end,
--   }
-- })

vim.notify = function(msg, level, opts)
	-- Filter out the specific TypeScript debug failure messages
	if msg:match("Debug Failure") or msg:match("False expression") then
		return
	end
	-- require("vim.notify")(msg, level, opts)
end

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
