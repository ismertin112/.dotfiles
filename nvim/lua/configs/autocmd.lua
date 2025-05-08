-- autocmd для автоматической проверки изменений на диске
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})

-- перехват события, когда файл был изменён вне буфера
vim.api.nvim_create_autocmd("FileChangedShell", {
  callback = function()
    vim.notify("⚠️ File changed on disk. Reloaded!", vim.log.levels.WARN)
    vim.cmd "edit!"
  end,
})
