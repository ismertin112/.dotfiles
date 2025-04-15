return {

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("nvim-tree").setup({
				renderer = {
					icons = {
						glyphs = {
							folder = { default = "", open = "", empty = "", empty_open = "" },
						},
					},
					highlight_opened_files = "icon",
				},
				filters = { dotfiles = false, custom = { ".git", "node_modules", "__pycache__" } },
				git = { ignore = false }, -- ❗ Показывать файлы из .gitignore
				view = { width = 30, side = "left", adaptive_size = true }, -- ✅ Исправлено
				actions = { open_file = { quit_on_open = true } },
			})
		end,
	},
	-- 🔍 Мощный пои
	--
	--
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope", -- Загружать по команде
		dependencies = {
			"nvim-lua/plenary.nvim", -- ТОЛЬКО ОСНОВНАЯ ЗАВИСИМОСТЬ
		},
		config = function()
			print("Minimal Telescope setup...")
			-- Просто вызываем setup БЕЗ каких-либо опций
			require("telescope").setup({
				-- Пусто! Никаких defaults, pickers, extensions
			})
			print("Minimal Telescope setup finished.")
			-- НЕ загружаем никаких расширений
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		lazy = false,
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-\>]],
				direction = "horizontal",
				size = 15,
				persist_size = true,
			})
		end,
	},

	-- 🛠 Поддержка GitLab CLI (glab)
	{
		"pwntester/octo.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		lazy = false,
		config = function()
			require("octo").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		config = function()
			vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true }) -- 🔥 Клавиша для запуска
		end,
	},
}
