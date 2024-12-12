return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = false, -- hide filtered items on open
				hide_gitignored = true,
				hide_dotfiles = false,
				hide_by_name = {
					".github",
					".gitignore",
					"package-lock.json",
					".changeset",
					".prettierrc.json",
				},
				never_show = { ".git" },
			},
		},
	},
	config = function()
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal toggle right<CR>", {})
	end,
}
