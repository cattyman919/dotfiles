return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
	config = function()
		require("telescope").setup({
			pickers = {
				help_tags = {
					theme = "ivy",
				},
				find_files = {
					theme = "ivy",
				},
				git_files = {
					theme = "ivy",
				},
				oldfiles = {
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
			},
		})
	end,
}
