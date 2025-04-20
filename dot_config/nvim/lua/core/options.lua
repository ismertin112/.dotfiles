-- lua/core/options.lua
-- Основные настройки редактора
local opt = vim.opt
local g = vim.g

-- [[ Визуальные настройки ]]
opt.termguicolors = true -- 24-bit цвета (True Color)
opt.number = true -- нумерация строк
opt.relativenumber = false -- относительная нумерация
opt.cursorline = true -- подсветка текущей строки
opt.wrap = false -- не переносить строки
opt.linebreak = true -- перенос по словам (для включенного wrap)
opt.showmode = false -- не показывать режим (--INSERT-- и т.д.)
opt.signcolumn = "yes" -- всегда показывать колонку значков (LSP, GitSigns)
opt.scrolloff = 8 -- контекст 8 строк при прокрутке
opt.sidescrolloff = 8 -- контекст 8 столбцов при горизонт. прокрутке
-- opt.colorcolumn = "80"   -- линия ограничителя 80 символов (при необходимости)
opt.clipboard = "unnamedplus" -- использовать системный буфер обмена

-- [[ Отступы ]]
opt.expandtab = true -- вставлять пробелы вместо табуляции
opt.tabstop = 4 -- таб = 4 пробела
opt.softtabstop = 4 -- таб при редактировании = 4 пробела
opt.shiftwidth = 4 -- авто-отступ = 4 пробела
opt.autoindent = true -- автоматический отступ новых строк
opt.smartindent = true -- интеллектуальный отступ

-- [[ Поиск ]]
opt.hlsearch = true -- подсветка найденного
opt.incsearch = true -- поиск по мере ввода
opt.ignorecase = true -- поиск без учета регистра...
opt.smartcase = true -- ... кроме случаев с заглавными буквами

opts = {
	indent = { char = "│" },
	scope = {
		enabled = true,
		show_start = true,
		show_end = false,
		highlight = { "IblScope" },
	},
	exclude = {
		filetypes = { "help", "dashboard", "neo-tree", "lazy", "mason" },
		buftypes = { "terminal", "nofile" },
	},
}

-- [[ Поведение ]]
opt.hidden = true -- фоновые буферы без сохранения
opt.mouse = "a" -- включить мышь во всех режимах
opt.splitright = true -- вертикальные сплиты справа
opt.splitbelow = true -- горизонтальные сплиты снизу
opt.completeopt = "menu,menuone,noselect" -- параметры автодополнения (для nvim-cmp)
opt.undofile = true -- включить неограниченный отмену (undo)
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
pcall(vim.fn.mkdir, opt.undodir:get(), "p")
opt.backup = false -- не сохранять backup-файлы
opt.writebackup = false -- не сохранять backup перед записью
opt.swapfile = false -- не использовать swap-файлы
opt.updatetime = 300 -- время (мс) для событий CursorHold (и swap/undo)
opt.timeoutlen = 500 -- время ожидания последовательности клавиш (мс)
opt.confirm = true -- запрашивать подтверждение при выходе с несохраненными изменениями
