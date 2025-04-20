-- lua/core/keymaps.lua Настройка горячих клавиш

vim.g.mapleader = " " -- пробел как глобальный лидер
vim.g.maplocalleader = "\\" -- бэкслэш как локальный лидер

local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- *** NORMAL mode ***

-- Сохранение файла (Ctrl+S)
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Сохранить файл", silent = true })

-- Буфер обмена (копирование выделенного в системный буфер)
map("v", "y", '"+y', { desc = "Копировать в системный буфер", noremap = true, silent = true })

-- Навигация по окнам (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h", { desc = "К окно слева", noremap = true })
map("n", "<C-j>", "<C-w>j", { desc = "К окно снизу", noremap = true })
map("n", "<C-k>", "<C-w>k", { desc = "К окно сверху", noremap = true })
map("n", "<C-l>", "<C-w>l", { desc = "К окно справа", noremap = true })

-- Управление окнами (<leader>w...)
map("n", "<leader>wv", "<C-w>v", { desc = "Вертикальный сплит", noremap = true })
map("n", "<leader>wh", "<C-w>s", { desc = "Горизонтальный сплит", noremap = true })
map("n", "<leader>wq", "<C-w>q", { desc = "Закрыть окно", noremap = true })
map("n", "<leader>wo", "<C-w>o", { desc = "Закрыть остальные окна", noremap = true })

-- Сохранение и выход (<leader>w, <leader>q, <leader>Q)
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Сохранить файл", noremap = true, silent = true })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Выйти", noremap = true, silent = true })
map(
	"n",
	"<leader>Q",
	"<cmd>qall!<CR>",
	{ desc = "Выйти без сохранения", noremap = true, silent = true }
)

-- Поиск и открытие (Fuzzy Finder via fzf-lua)
-- (См. привязки <leader>ff, fg, fb... в конфигурации плагина fzf-lua)

-- LSP: базовые функции (задаются при подключении LSP-сервера в on_attach)
-- (hover, goto definition, etc. см. plugins/mason.lua)

-- *** INSERT mode ***

-- Быстрый выход из режима вставки (jk или kj)
map("i", "jk", "<ESC>", { desc = "Выход из режима вставки", noremap = true, silent = true })
map("i", "kj", "<ESC>", { desc = "Выход из режима вставки", noremap = true, silent = true })

-- trouble

map("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })
map("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
map("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", { desc = "LSP references" })
map("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "TODOs in Trouble" }) -- если используешь todo-comments
-- nvim-cmp (автодополнение)
-- (Привязки Tab/S-Tab настроены в конфигурации cmp.lua)
-- Codeium

-- Принять предложение
map("i", "<C-Tab>", function()
	return vim.fn["codeium#Accept"]()
end, {
	expr = true,
	desc = "Codeium Accept Suggestion",
})

-- Следующее предложение
map("i", "<M-]>", function()
	return vim.fn
end, {
	expr = true,
	desc = "Codeium Next Suggestion",
})

-- Предыдущее предложение
map("i", "<M-[>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, {
	expr = true,
	desc = "Codeium Prev Suggestion",
})

-- Отклонить
map("i", "<C-x>", function()
	return vim.fn["codeium#Clear"]()
end, {
	expr = true,
	desc = "Codeium Clear Suggestion",
})

-- Используем Ctrl+j/Ctrl+k для навигации, Enter для подтверждения (см. plugins/cmp.lua)

map("n", "<leader>o", "<cmd>AerialToggle<cr>", { desc = "Toggle outline (Aerial)" })
map("n", "<leader>O", "<cmd>AerialNavToggle<cr>", { desc = "Toggle nav window" })
-- *** VISUAL mode ***

-- Быстрая настройка отступов (выделение и > / <)
map("v", ">", ">gv", { desc = "Увеличить отступ", noremap = true, silent = true })
map("v", "<", "<gv", { desc = "Уменьшить отступ", noremap = true, silent = true })

vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run current file tests" })
vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true })
end, { desc = "Open test output" })
vim.keymap.set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })
-- (Опционально: перемещение выделенных строк клавишами J/K)
