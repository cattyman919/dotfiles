return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	config = function(_, opts)
		require("nvim-tree").setup(opts)
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<C-n>", api.tree.toggle, { desc = "" })
	end,
	opts = {
		filters = { dotfiles = false },
		disable_netrw = true,
		hijack_cursor = true,
		sync_root_with_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = false,
		},
		view = {
			side = "right",
			width = 40,
			preserve_window_proportions = true,
		},
		renderer = {
			root_folder_label = false,
			highlight_git = true,
			indent_markers = { enable = true },
			icons = {
				glyphs = {
					default = "󰈚",
					folder = {
						default = "",
						empty = "",
						empty_open = "",
						open = "",
						symlink = "",
					},
					git = { unmerged = "" },
				},
			},
		},
	},
}
