-- Shows the tab list
return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			-- You can customize bufferline options here
			always_show_bufferline = true,
			diagnostics = "nvim_lsp",
		},
	},
	-- Adding keymaps specifically for bufferline
	keys = {
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer/Tab" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer/Tab" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer/Tab" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer/Tab" },
		{
			"<leader>bd",
			function()
				require("snacks").bufdelete()
			end,
			desc = "Close Current Buffer",
		},
	},
}
