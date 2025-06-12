return {
	-- In your lazy.nvim setup (e.g., lua/plugins/format.lua or similar)
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- Load early enough for format-on-save
		-- cmd = { "ConformInfo" }, -- You can use this if you prefer loading on command
		opts = {
			notify_on_error = true,
			-- Configure format on save
			format_on_save = {
				timeout_ms = 1000, -- Set a timeout for format on save
				lsp_fallback = true, -- Fallback to LSP formatting if conform.nvim doesn't have a formatter or fails
				-- If true, conform will try LSP formatting if its own formatters fail or aren't set up for the buffer.
				-- If you only want conform.nvim's defined formatters, set this to false.
			},
			-- Define your formatters by filetype
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "black" }, -- Tries ruff_format first, then black
				javascript = { "biome", "prettierd", "prettier" }, -- prettierd is faster if available
				typescript = { "biome", "prettierd", "prettier" },
				javascriptreact = { "biome", "prettierd", "prettier" },
				typescriptreact = { "biome", "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				sh = { "shfmt" },
				go = { "gofmt", "goimports" },
				php = { "prettier" },

				-- Example of using a formatter that isn't a default
				-- zig = { "zigfmt" },

				-- You can also define a global fallback or a formatter for any filetype
				["_"] = { "trim_newlines", "trim_whitespace" }, -- Applies to all filetypes if no specific formatter is found / runs after specific ones
			},

			-- You can define custom formatters if needed
			-- formatters = {
			--   my_custom_formatter = {
			--     cmd = "my_formatter_executable",
			--     args = { "--stdin" },
			--     stdin = true, -- Indicates the formatter reads from stdin
			--   }
			-- }
		},
		-- You can also put keymaps in init if you want them defined even earlier
		init = function()
			-- Set a keymap for manual formatting
			vim.keymap.set({ "n", "v" }, "<leader>fm", function() -- "fm" for "manual format"
				require("conform").format({ async = false, lsp_fallback = true, timeout_ms = 1000 })
				print("Formatted with conform.nvim")
			end, { desc = "Format buffer with conform.nvim" })
		end,
	},
}
