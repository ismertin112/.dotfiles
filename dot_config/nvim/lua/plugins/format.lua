-- lua/plugins/format.lua
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black", "isort" },
			go = { "goimports", "gofmt" },
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
			scss = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			yaml = { "prettierd", "prettier" },
			toml = { "taplo" },
			markdown = { "prettierd", "prettier" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			-- ["_"] = { "trim_whitespace" }, -- общие форматтеры для любых файлов
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		-- Можно добавить свои форматтеры, если их нет:
		-- formatters = {
		--   my_formatter = {
		--     cmd = "my_cmd",
		--     args = {"--stdin"},
		--     stdin = true,
		--   }
		-- }
	},
}
