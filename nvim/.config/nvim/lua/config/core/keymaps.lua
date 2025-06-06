-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>") -- Source File
vim.keymap.set("n", "<C-s>", ":write<CR>") -- Save file with CTRL + S
vim.keymap.set("n", "<C-c>", ":%y<CR>", opts) -- Copy all lines in buffer

-- Moves Lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

-- Navigations
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv") -- Center Cursor when navigating with n
vim.keymap.set("n", "N", "Nzzzv")

-- ctrl c as escape cuz Im lazy to reach up to the esc key
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

-- prevent x delete from registering when next paste
vim.keymap.set("n", "x", '"_x', opts)

-- Diagnostics

-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<C-x>", function()
	isLspDiagnosticsVisible = not isLspDiagnosticsVisible
	vim.diagnostic.config({
		virtual_text = isLspDiagnosticsVisible,
		underline = isLspDiagnosticsVisible,
	})
end, { desc = "Toggle LSP diagnostics" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list (location)" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Open diagnostics list (quickfix)" })

-- Terminals
vim.keymap.set("n", "<space>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 5)
end, { desc = "Open small terminal at bottom" })
