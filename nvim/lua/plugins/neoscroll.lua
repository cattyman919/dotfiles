return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	config = function()
		local neoscroll = require("neoscroll")

		neoscroll.setup({
			-- Hide cursor while scrolling creates a "floating" feel
			hide_cursor = true,
			-- Stop at end of file (prevent scrolling into the void)
			stop_eof = true,
			-- "quadratic" is a popular easing function for a natural feel
			easing = "quadratic",
			-- Default keys to hijack for smooth scrolling
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
		})
		local modes = { "n", "v", "x" }

		-- CUSTOM KEYMAPS
		-- These implement the "Fast Scroll" you wanted:
		-- <C-j>: Scrolls down 10 lines smoothly
		-- <C-k>: Scrolls up 10 lines smoothly
		local scroll_opts = { move_cursor = true, duration = 100 }

		vim.keymap.set(modes, "<C-j>", function()
			neoscroll.scroll(10, scroll_opts)
		end, { desc = "Smooth scroll down" })

		vim.keymap.set(modes, "<C-k>", function()
			neoscroll.scroll(-10, scroll_opts)
		end, { desc = "Smooth scroll up" })
	end,
}
