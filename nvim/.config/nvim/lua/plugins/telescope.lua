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
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<space>fh", builtin.help_tags, { desc = "Find help tags" })

		vim.keymap.set("n", "<space>ff", function()
			-- Check if is in a git repo
			builtin.find_files({ desc = "Find files" })
			-- vim.fn.system("git rev-parse --is-inside-work-tree > /dev/null 2>&1")
			--
			-- if vim.v.shell_error == 0 then
			-- 	builtin.git_files({ desc = "Find git files" })
			-- else
			-- 	builtin.find_files({ desc = "Find files" })
			-- end
		end, { desc = "Find files (Git or All)" })

		vim.keymap.set("n", "<space>fo", builtin.oldfiles, { desc = "Find old files" })
		vim.keymap.set("n", "<space>fj", builtin.jumplist, { desc = "Find jump list" })
		vim.keymap.set("n", "<space>fw", builtin.live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<space>fs", builtin.lsp_document_symbols, { desc = "Buffer LSP Symbols" })

		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to Definition" })
		vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Find references" })

		-- Telescope to Neovim Config Files
		vim.keymap.set("n", "<space>en", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end)
	end,
}
