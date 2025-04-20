return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-go",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-go")({
					experimental = {
						test_table = true,
					},
					args = { "-count=1", "-timeout=30s" },
				}),
			},
		})
	end,
}
