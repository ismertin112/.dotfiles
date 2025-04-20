-- init.lua
-- Главный конфигурационный файл Neovim (с Neovide)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- Отключение встроенного плагина netrw (его заменит neo-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Настройки Neovide GUI (если используется)
vim.g.neovide_refresh_rate = 100
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.1
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_floating_shadow = false
vim.g.neovide_confirm_quit = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_input_use_logo = true -- позволяет использовать <D-?> сочетания на macOS
vim.o.guifont = "Maple Mono NF:h16"
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_opacity = 0.95
-- Установим фоновый цвет с 90% непрозрачности (для эффекта transparency)
vim.g.neovide_background_color = "#1e1e2e" .. string.format("%x", math.floor(255 * 0.9))

-- Настройка формы курсора в разных режимах
vim.opt.guicursor = {
	"n-v-c:blinkon0",
	"i-ci-ve:ver25",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkon0",
}

-- 1. Базовые настройки (Options)
pcall(require, "core.options")

-- 2. Менеджер плагинов (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	install = { colorscheme = { "catppuccin", "habamax" } },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- 3. Горячие клавиши (Keymaps)
pcall(require, "core.keymaps")
