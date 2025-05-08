pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = {
    "luadoc",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "printf",
    "vim",
    "vimdoc",
    "lua",
    "html",
    "css",
    "json5",
    "yaml",
    "c",
    "sql",
    "php",
    "terraform",
    "hcl",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}
