-- lua/plugins/treesitter.lua
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			ensure_installed = { "lua", "go", "bash", "yaml", "json", "terraform" },
		},
	},
}
