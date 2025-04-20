-- lua/plugins/ui.lua
--s Внешний вид и интерфейс
return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "moon", -- или storm, night, day
			transparent = false,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
			},
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	-- Иконки (для файлов, LSP и пр.)
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	-- Which-Key (помощник для горячих клавиш)

	{
		"echasnovski/mini.clue",
		version = false,
		config = function()
			local clue = require("mini.clue")
			clue.setup({
				triggers = {
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-x>" },
					{ mode = "n", keys = "<C-w>" },
				},

				clues = {
					clue.gen_clues.builtin_completion(),
					clue.gen_clues.g(),
					clue.gen_clues.marks(),
					clue.gen_clues.registers(),
					clue.gen_clues.windows(),
					clue.gen_clues.z(),
					-- можно добавить свои:
					{ mode = "n", keys = "<Leader>f", desc = "Поиск" },
					{ mode = "n", keys = "<Leader>g", desc = "Git" },
					{ mode = "n", keys = "<Leader>d", desc = "Отладка" },
					{ mode = "n", keys = "<Leader>w", desc = "Окна" },
					{ mode = "n", keys = "<Leader>l", desc = "LSP" },
				},

				window = {
					config = {
						border = "rounded",
					},
				},
			})
		end,
	},

	-- lua/plugins/lualine.lua (можно в ui.lua встроить)
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local navic = require("nvim-navic")
			local colors = require("tokyonight.colors").setup()

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "|", right = "|" },
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							icon = "",
							separator = { left = "", right = "" },
							color = { fg = colors.bg, bg = colors.blue },
							padding = { left = 1, right = 1 },
						},
					},
					lualine_b = {
						{ "branch", icon = "", color = { fg = colors.fg, bg = colors.bg_highlight } },
						{
							"diff",
							symbols = { added = " ", modified = " ", removed = " " },
							color = { fg = colors.fg_dark },
						},
					},
					lualine_c = {
						{ "filename", path = 1, color = { fg = colors.fg } },
						{
							navic.get_location,
							cond = navic.is_available,
							color = { fg = colors.comment },
						},
					},
					lualine_x = {
						{
							function()
								local clients = vim.lsp.get_active_clients({ bufnr = 0 })
								if #clients == 0 then
									return "No LSP"
								end
								return "LSP: " .. clients[1].name
							end,
							icon = " ",
							cond = function()
								return vim.bo.filetype ~= "" and vim.bo.filetype ~= "dashboard"
							end,
							color = { fg = colors.teal },
						},
						{
							function()
								return os.getenv("CONDA_DEFAULT_ENV")
									or (os.getenv("VIRTUAL_ENV") and vim.fn.fnamemodify(os.getenv("VIRTUAL_ENV"), ":t"))
									or ""
							end,
							icon = " ",
							cond = function()
								return vim.bo.filetype == "python"
							end,
							color = { fg = colors.yellow },
						},
						{
							"diagnostics",
							sources = { "nvim_lsp" },
							symbols = { error = " ", warn = " ", info = " " },
							sections = { "error", "warn", "info" },
							colored = true,
							color = { fg = colors.red },
						},
						"encoding",
						"fileformat",
						"filetype",
					},
					lualine_y = {
						{ "progress", color = { fg = colors.comment } },
					},
					lualine_z = {
						{
							"location",
							separator = { left = "", right = "" },
							color = { fg = colors.bg, bg = colors.blue },
							padding = { left = 1, right = 1 },
						},
					},
				},
				inactive_sections = {
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "location" },
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	}, -- Вкладки буферов
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				numbers = "ordinal",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict)
					local icon = (level:match("error") and " ") or (level:match("warning") and " ") or ""
					return " " .. count .. icon
				end,
				separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
				offsets = {
					{ filetype = "neo-tree", text = "󰙅 Explorer", text_align = "left", separator = true },
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},
	-- Линии отступов
	-- Улучшенные сообщения и UI команд
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
				routes = {
					{
						filter = { event = "msg_show", kind = "", find = "written" },
						opts = { skip = true },
					},
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {
			indent = { char = "│" },
			scope = { enabled = true, show_start = true, show_end = false },
			exclude = {
				filetypes = { "help", "alpha", "dashboard", "neo-tree", "lazy", "mason" },
				buftypes = { "terminal", "nofile" },
			},
		},
		config = function(_, opts)
			local colors = require("tokyonight.colors").setup()
			vim.api.nvim_set_hl(0, "IblIndent", { fg = colors.blue })
			vim.api.nvim_set_hl(0, "IblScope", { fg = colors.mauve })
			require("ibl").setup(opts)
		end,
	}, -- Автофокус окон
	{
		"nvim-focus/focus.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
			enable = true,
			autoresize = { enable = true, width_ratio = 0.7, height_ratio = 0.7 },
			split = { focus_new = true, resize_new = true },
		},
		config = function(_, opts)
			require("focus").setup(opts)
		end,
	},

	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			-- Цвета из TokyoNight (moon/storm/night)
			local colors = {
				red = "#f7768e",
				yellow = "#e0af68",
				sky = "#7dcfff",
				overlay = "#565f89", -- слегка приглушённый
				teal = "#1abc9c",
			}

			vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = colors.red })
			vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = colors.yellow })
			vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = colors.sky })
			vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = colors.overlay })
			vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = colors.teal })

			vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = colors.red })
			vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = colors.yellow })
			vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = colors.sky })
			vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = colors.overlay })
			vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = colors.teal })

			vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = colors.red })
			vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = colors.yellow })
			vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = colors.sky })
			vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = colors.overlay })
			vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = colors.teal })

			require("notify").setup({
				stages = "fade_in_slide_out",
				timeout = 3000,
				max_height = function()
					return math.floor(vim.o.lines * 0.75)
				end,
				max_width = function()
					return math.floor(vim.o.columns * 0.75)
				end,
				render = "default",
				minimum_width = 50,
				icons = {
					ERROR = "",
					WARN = "",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},
			})

			vim.notify = require("notify")
		end,
	},

	-- Улучшенные диалоговые окна (input/select)
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			select = {
				backend = { "telescope", "fzf", "builtin" },
				builtin = {
					relative = "editor",
					border = "rounded",
				},
			},
			input = {
				relative = "cursor",
				border = "rounded",
				win_options = { winblend = 0 },
			},
		},
	},
	-- Плавный скроллинг
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup()
		end,
	},
}
