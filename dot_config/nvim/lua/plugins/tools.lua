-- lua/plugins/tools.lua
-- Инструменты: fuzzy finder, терминал, Git
return {
	-- FZF-Lua (фуззи-поиск файлов и др.)
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Поиск файлов" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Поиск по содержимому" },
			{ "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Список буферов" },
			{ "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc = "Недавние файлы" },
			{ "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "Поиск в справке" },
			{ "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc = "Поиск по привязкам" },
		},
		opts = {
			winopts = {
				preview = { layout = "vertical", vertical = "down:60%" },
			},
			files = { prompt = "Files❯ ", git_icons = true },
			grep = { prompt = "Rg❯ " },
		},
	},
	-- Файловый менеджер (дерево)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Explorer Toggle",
			},
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, reveal = true })
				end,
				desc = "Explorer Reveal File",
			},
		},
		opts = {
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				indent = { indent_size = 2 },
				-- icons: по умолчанию nvim-web-devicons
				git_status = {
					symbols = { added = "A", modified = "M", deleted = "D", renamed = "R" },
				},
			},
			window = {
				position = "left",
				width = 30,
				mapping_options = { noremap = true, nowait = true },
				mappings = {
					["<space>"] = false,
					["<CR>"] = "open",
					["o"] = "open",
					["<esc>"] = "cancel",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["l"] = "focus_preview",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					-- ["t"] = "open_tabnew",
					["a"] = "add",
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["H"] = "toggle_hidden",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_hidden = false,
					never_show = { ".DS_Store", "thumbs.db" },
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				hijack_netrw_behavior = "open_current",
			},
			buffers = { follow_current_file = { enabled = true } },
			git_status = {
				symbols = {
					added = "A",
					modified = "M",
					deleted = "D",
					renamed = "R",
				},
			},
		},
	},
	-- Терминал (ToggleTerm) + интеграция LazyGit
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<leader>lg", "<cmd>TermExec cmd='lazygit' direction=float<CR>", desc = "LazyGit" },
		},
		opts = {
			-- открытие терминала по Ctrl+\\ (по умолчанию)
			-- здесь настраиваем только LazyGit через <leader>lg
		},
	},
	-- Git интеграция (знаки в боковой колонке, навигация по изменениям)
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end
				map("n", "]c", gs.next_hunk, "Next Hunk")
				map("n", "[c", gs.prev_hunk, "Prev Hunk")
				map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>gh", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
			end,
		},
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
}
