-- lua/plugins/misc.lua
-- Различные улучшения редактирования
return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
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
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = { { "<leader>o", "<cmd>SymbolsOutline<CR>", desc = "Структура кода" } },
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- Можно настроить ключевые слова и их вид (FIX, TODO, HACK, etc.)
			-- telescope = { -- интеграция с Telescope для поиска по TODO }
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
		},
	},

	{
		"stevearc/aerial.nvim",
		opts = {},
		cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
	},
}
