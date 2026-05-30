return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	keys = {
		{ "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)
	end,
	---@type nvim_tree.config
	opts = {
		filters = { dotfiles = false },
		disable_netrw = true,
		hijack_cursor = true,
		sync_root_with_cwd = true,
		update_focused_file = {
			enable = false,
			update_root = {
				enable = false,
			},
		},
		view = {
			side = "left",
			width = {
				min = 30,
				max = -1,
			},
			preserve_window_proportions = true,
		},
		diagnostics = {
			enable = true,
		},
		renderer = {
			root_folder_label = false,
			hidden_display = "all",
			-- highlight_git = "icon",
			-- highlight_modified = "icon",
			-- highlight_diagnostics = "icon",
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
		-- modified = {
		-- 	enable = true,
		-- 	show_on_dirs = true,
		-- 	show_on_open_dirs = true,
		-- },
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
	},
}
