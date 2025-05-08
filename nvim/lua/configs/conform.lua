local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "jq" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    yaml = { "yamlfix" },
    sql = { "pgformatter" },
    php = { "prettier" },
    hcl = { "packer_fmt" },
    terraform = { "terraform_fmt" },
    tf = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
  },
  formatters = {
    ["goimports-reviser"] = {
      prepend_args = { "-rm-unused" },
    },
    golines = {
      prepend_args = { "--max-len=80" },
    },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
}

require("conform").setup(options)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})
