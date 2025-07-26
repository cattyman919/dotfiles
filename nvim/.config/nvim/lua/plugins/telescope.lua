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
					hidden = true,
					no_ignore = false,
					theme = "ivy",
				},
				lsp_references = {
					theme = "ivy",
				},
				lsp_definition = {
					theme = "ivy",
				},
				lsp_implementations = {
					theme = "ivy",
				},
				lsp_document_symbols = {
					theme = "ivy",
				},
				lsp_workspace_symbols = {
					theme = "ivy",
				},
				lsp_dynamic_workspace_symbols = {
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
