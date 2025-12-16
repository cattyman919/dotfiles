return { -- Those are the default options
	"bassamsdata/namu.nvim",
	opts = {
		namu_symbols = {
			options = {
				display = {
					icon = "icon",
					format = "tree_guides",
				},
				-- This is a preset that let's set window without really get into the hassle of tuning window options
				-- top10 meaning top 10% of the window
				row_position = "top10", -- options: "center"|"top10"|"top10_right"|"center_right"|"bottom",
			},
		},
	},
}
