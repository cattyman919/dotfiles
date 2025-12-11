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
			post_hook = function(info)
				if info == "zz" then
					vim.cmd("normal! zz") -- Center the cursor
				end
			end,
		})

		-- Define parameters for our scrolling commands
		-- "info = 'zz'" tells the post_hook to center the screen when done
		local fast_dur = 100 -- Faster animation for J/K
		local page_dur = 250 -- Standard speed for half-pages

		local modes = { "n", "v", "x" }
		local scroll_opts = { move_cursor = true, duration = fast_dur, info = {
			post_hook = "zz",
		} }

		-- 1. Fast Vertical Scroll (10 lines) + Center
		-- Syntax: scroll(lines, move_cursor, time, easing, info)
		vim.keymap.set(modes, "<C-j>", function()
			neoscroll.scroll(10, scroll_opts)
		end, { desc = "Fast scroll down & center" })

		vim.keymap.set(modes, "<C-k>", function()
			neoscroll.scroll(-10, scroll_opts)
		end, { desc = "Fast scroll up & center" })

		-- 2. Half-Page Scroll (<C-d> / <C-u>) + Center
		-- We use the helper functions which handle the 'window scroll amount' math
		vim.keymap.set(modes, "<C-d>", function()
			neoscroll.ctrl_d({ duration = page_dur, info = {
				post_hook = "zz",
			} })
		end, { desc = "Scroll down half page & center" })

		vim.keymap.set(modes, "<C-u>", function()
			neoscroll.ctrl_u({ duration = page_dur, info = {
				post_hook = "zz",
			} })
		end, { desc = "Scroll up half page & center" })
	end,
}
