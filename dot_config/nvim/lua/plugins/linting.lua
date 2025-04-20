-- lua/plugins/linting.lua
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			python = { "ruff" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			go = { "revive" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			terraform = { "tflint" },
			yaml = { "yamllint" },
			markdown = { "markdownlint" },
			ansible = { "ansible-lint" },
			-- добавьте при необходимости
		}
		local lint_augroup = vim.api.nvim_create_augroup("Lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			group = lint_augroup,
			pattern = "*",
			desc = "Run nvim-lint",
			callback = function(args)
				vim.schedule(function()
					lint.try_lint(nil, { bufnr = args.buf })
				end)
			end,
		})
		-- (Опционально) ручной запуск: :lua require("lint").try_lint()
	end,
}
