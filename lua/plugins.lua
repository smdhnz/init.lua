return {

	-----------------------------------------------------------------------------

	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = true,
	},

	-----------------------------------------------------------------------------

	{
		"phaazon/hop.nvim",
		branch = "v2",
		keys = {
			{ "s", "<CMD>HopWord<CR>", silent = true, noremap = true },
		},
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},

	-----------------------------------------------------------------------------

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
				},
				hide_inactive_statusline = true,
				dim_inactive = true,
				lualine_bold = true,
			})
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},

	-----------------------------------------------------------------------------

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "e", "<CMD>Neotree<CR>", silent = true, noremap = true },
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				enable_git_status = true,
				enable_diagnostics = true,
				window = {
					position = "float",
					mappings = {
						["<space>"] = { "toggle_node", nowait = false },
						["a"] = { "add", config = { show_path = "relative" } },
						["d"] = "delete",
						["m"] = "move",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["e"] = "close_window",
						["<"] = "prev_source",
						[">"] = "next_source",
					},
				},
				filesystem = {
					filtered_items = {
						hide_by_name = { "node_modules" },
					},
					window = {
						mappings = {
							["."] = "toggle_hidden",
							["u"] = "navigate_up",
							["o"] = "set_root",
						},
					},
				},
			})
		end,
	},

	-----------------------------------------------------------------------------

	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				signcolumn = true,
				numhl = true,
				linehl = true,
			})
		end,
	},

	-----------------------------------------------------------------------------

	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "q", "<CMD>LazyGit<CR>", silent = true, noremap = true },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 1
			vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" }
		end,
	},

	-----------------------------------------------------------------------------

	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					sections = {
						lualine_a = { "mode" },
						lualine_b = { "branch", "diff", "diagnostics" },
						lualine_c = { { "filename", path = 1 } },
						lualine_x = { "encoding", "fileformat", "filetype" },
						lualine_y = { "progress" },
						lualine_z = { "location" },
					},
				},
			})
		end,
	},

	-----------------------------------------------------------------------------

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<C-\\>", "<CMD>ToggleTerm<CR>", silent = true, noremap = true },
		},
		config = function()
			require("toggleterm").setup({
				direction = "float",
			})

			vim.api.nvim_create_autocmd({ "TermEnter" }, {
				pattern = { "term://*toggleterm#*" },
				callback = function()
					vim.api.nvim_set_keymap("t", "<C-\\>", '<CMD>exe v:count1 . "ToggleTerm"<CR>', { silent = true })
				end,
			})
		end,
	},

	-----------------------------------------------------------------------------

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		dependencies = { "yioneko/nvim-yati" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"json",
					"yaml",
					"tsx",
					"typescript",
					"python",
					"markdown",
				},
				auto_install = false,
				highlight = { enable = true },
				autotag = { enable = true },
				indent = { enable = false },
				yati = { enable = true, disable = { "python", "markdown" } },
			})
		end,
	},

	-----------------------------------------------------------------------------

	{
		"junnplus/lsp-setup.nvim",
		lazy = false,
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim", -- optional
			"williamboman/mason-lspconfig.nvim", -- optional
		},
		config = function()
			require("lsp-setup").setup({
				default_mappings = false,
				mappings = {
					["F"] = "lua vim.lsp.buf.hover()",
					["f"] = "lua vim.diagnostic.open_float()",
					["[d"] = "lua vim.diagnostic.goto_prev()",
					["]d"] = "lua vim.diagnostic.goto_next()",
				},
				on_attach = function() end,
				capabilities = vim.lsp.protocol.make_client_capabilities(),
				servers = {
					tsserver = {},
					lua_ls = {
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					},
				},
			})
		end,
	},

	-----------------------------------------------------------------------------

	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")

			local lsp_symbols = {
				Text = "[Text]",
				Method = "[Method]",
				Function = "[Function]",
				Constructor = "[Constructor]",
				Field = "[Field]",
				Variable = "[Variable]",
				Class = "[Class]",
				Interface = "[Interface]",
				Module = "[Module]",
				Property = "[Property]",
				Unit = "[Unit]",
				Value = "[Value]",
				Enum = "[Enum]",
				Keyword = "[Keyword]",
				Snippet = "[Snippet]",
				Color = "[Color]",
				File = "[File]",
				Reference = "[Reference]",
				Folder = "[Folder]",
				EnumMember = "[EnumMember]",
				Constant = "[Constant]",
				Struct = "[Struct]",
				Event = "[Event]",
				Operator = "[Operator]",
				TypeParameter = "[TypeParameter]",
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "luasnip" },
				},
				mapping = cmp.mapping.preset.insert({
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				experimental = {
					ghost_text = true,
				},
				formatting = {
					format = function(entry, item)
						item.kind = lsp_symbols[item.kind]
						item.menu = ({
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							path = "[Path]",
							luasnip = "[Snippet]",
						})[entry.source.name]
						return item
					end,
				},
			})
		end,
	},

	-----------------------------------------------------------------------------

	{
		"stevearc/conform.nvim",
		lazy = false,
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier_d", "prettier" },
					typescript = { "prettier_d", "prettier" },
				},
			})

			-- Format asynchronously on save
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ async = true, lsp_fallback = true, bufnr = args.buf }, function(err)
						if not err then
							vim.api.nvim_buf_call(args.buf, function()
								vim.cmd.update()
							end)
						end
					end)
				end,
			})
		end,
	},
}
