-- AutoCommands

-- See `:help vim_highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd({
	"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
	"BufWinEnter",
	"CursorHold",
	"InsertLeave",

	-- include this if you have set `show_modified` to `true`
	"BufModifiedSet",
}, {
	group = vim.api.nvim_create_augroup("barbecue.updater", {}),
	callback = function()
		require("barbecue.ui").update()
	end,
})

vim.api.nvim_create_augroup("BashSheBang", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = "BashSheBang",
	callback = function(args)
		local lines = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false) or ""

		if #lines > 0 then
			local first_line = lines[1]
			if string.match(first_line, "^#!.*[ /]bash") or string.match(first_line, "^#!.*[ /]sh") then
				vim.bo[args.buf].filetype = "sh"
			end
		end
	end,
})
