return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			delay = 200,
			large_file_cutoff = 2000,
			under_cursor = true,
		})
	end,
}
