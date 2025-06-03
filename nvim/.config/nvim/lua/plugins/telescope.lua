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
				oldfiles = {
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
			},
		})
		vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags, { desc = "Find help tags" })
		vim.keymap.set("n", "<space>ff", require("telescope.builtin").find_files, { desc = "Find files in CWD" })
		vim.keymap.set("n", "<space>fo", require("telescope.builtin").oldfiles, { desc = "Find old files" })
		vim.keymap.set("n", "<space>fw", require("telescope.builtin").live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<space>en", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end)
	end,
}
