-- lua/plugins/mason.lua
-- Mason: ¿¿¿¿¿¿¿¿¿ LSP/DAP/Tools
return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "",
					package_pending = "",
					package_uninstalled = "",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = function()
			local ensure = {
				"ansiblels",
				"bashls",
				"dockerls",
				"gopls",
				"helm_ls",
				"html",
				"jsonls",
				"lua_ls",
				"marksman",
				"pyright",
				"taplo",
				"yamlls",
				"clangd",
				"rust_analyzer",
			}
			return { ensure_installed = ensure }
		end,
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local function on_attach(client, bufnr)
				local map = vim.keymap.set
				local lsp_opts = { buffer = bufnr, silent = true }
				map("n", "K", vim.lsp.buf.hover, lsp_opts)
				map("n", "gd", vim.lsp.buf.definition, lsp_opts)
				map("n", "gD", vim.lsp.buf.declaration, lsp_opts)
				map("n", "gi", vim.lsp.buf.implementation, lsp_opts)
				map("n", "go", vim.lsp.buf.type_definition, lsp_opts)
				map("n", "gr", vim.lsp.buf.references, lsp_opts)
				map("n", "<leader>rn", "<cmd>IncRename<CR>", lsp_opts)
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, lsp_opts)
				map("n", "<leader>d", vim.diagnostic.open_float, lsp_opts)
				map("n", "[d", vim.diagnostic.goto_prev, lsp_opts)
				map("n", "]d", vim.diagnostic.goto_next, lsp_opts)
			end

			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup_handlers({
				function(server)
					lspconfig[server].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
				-- ¿¿¿¿¿¿¿¿¿¿¿ ¿¿¿¿¿¿¿¿¿ ¿¿¿ ¿¿¿¿¿¿¿¿¿ ¿¿¿¿¿¿:
				["yamlls"] = function()
					lspconfig.yamlls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							yaml = {
								schemastore = { enable = true, url = "" },
								schemas = require("schemastore").yaml.schemas(),
								validate = true,
								format = { enable = true },
							},
						},
					})
				end,
				["jsonls"] = function()
					lspconfig.jsonls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
								workspace = { checkThirdParty = false },
								telemetry = { enable = false },
							},
						},
					})
				end,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				-- ¿¿¿¿¿¿¿¿¿¿:
				"stylua",
				"black",
				"isort",
				"goimports",
				"prettierd",
				"shfmt",
				"terraform-ls",
				"taplo",
				"rustfmt",
				"ruff",
				"eslint_d",
				"shellcheck",
				"tflint",
				"yamllint",
				"markdownlint",
				"ansible-lint",
				"revive",
				-- Debugger:
				"delve",
				-- (Go tools: gomodifytags, impl, iferr ¿¿¿¿¿ ¿¿¿¿¿¿¿¿ ¿¿¿ ¿¿¿¿¿¿¿¿¿¿¿¿¿)
			},
		},
	},
}
