-- lua/plugins/lsp.lua
-- LSP и связанные улучшения
return {
	-- JSON/YAML схемы
	{
		"b0o/SchemaStore.nvim",
		event = "VeryLazy",
	},
	-- Настройки LSP сервера (lspconfig + Mason)
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/SchemaStore.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		-- основная настройка LSP производится ниже через mason-lspconfig
	},
	-- Навигация по символам (breadcrumbs)
	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig", "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			lsp = { auto_attach = true },
			highlight = true,
			separator = " > ",
			depth_limit = 5,
			click = true,
		},
	},
	-- Прогресс LSP (индикатор загрузки)
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			text = { spinner = "dots" },
			window = { winblend = 0, relative = "editor" },
			-- filter шумных клиентов при необходимости:
			-- fmt = { max_messages = 3 }
		},
	},
	-- Улучшенное переименование (incremental rename)
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = function()
			require("inc_rename").setup({
				input_buffer_type = "dressing", -- использовать dressing.nvim для ввода
				preview_highlight_group = "Visual",
			})
		end,
	},
}
