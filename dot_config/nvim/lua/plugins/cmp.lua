-- lua/plugins/cmp.lua
return {
	-- Автодополнение (nvim-cmp + связанные плагины)
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			-- Движок сниппетов
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					local luasnip = require("luasnip")
					luasnip.setup(opts)
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })
					-- Пример: добавление пользовательских сниппетов (Lua)
					require("luasnip.loaders.from_lua").lazy_load({
						paths = vim.fn.stdpath("config") .. "/lua/custom/snippets",
					})

					-- Привязка Tab для перехода по места заполнения сниппета
					vim.keymap.set({ "i", "s" }, "<Tab>", function()
						if require("luasnip").expand_or_jumpable() then
							return require("luasnip").expand_or_jump()
						else
							return "<Tab>"
						end
					end, { expr = true, silent = true })

					vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
						if require("luasnip").jumpable(-1) then
							return require("luasnip").jump(-1)
						end
					end, { expr = true, silent = true })
				end,
			},
			-- Иконки для автодополнения
			{
				"onsails/lspkind.nvim",
				opts = {
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
				},
			},
			-- AI-подсказки (неактивно, опционально)
			{ "Exafunction/codeium.nvim", cmd = "Codeium" },
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local source_mapping = {
				buffer = "[BUF]",
				nvim_lsp = "[LSP]",
				luasnip = "[SNIP]",
				nvim_lua = "[VIM]",
				path = "[PATH]",
				cmdline = "[CMD]",
				codeium = "[AI]",
			}
			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "codeium" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					format = function(entry, vim_item)
						if vim_item.kind and vim_item.kind ~= "" then
							vim_item.kind = lspkind.presets.default[vim_item.kind] or vim_item.kind
						end
						vim_item.menu = source_mapping[entry.source.name] or entry.source.name
						return vim_item
					end,
				},
				experimental = {
					-- ghost_text = true
				},
			})
			-- Настройка автодополнения в командной строке (поиск и команды)
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
