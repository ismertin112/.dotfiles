return {
	"echasnovski/mini.starter",
	config = function()
		require("mini.starter").setup({
			items = {
				{ name = "Find file", action = "Telescope find_files", section = "Telescope" },
				{ name = "Recent files", action = "Telescope oldfiles", section = "Telescope" },
				{ name = "Edit config", action = "e $MYVIMRC", section = "Config" },
				{ name = "Quit", action = "qa", section = "Session" },
			},
			header = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]],
		})
	end,
}
