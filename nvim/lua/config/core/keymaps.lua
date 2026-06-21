-- Keymaps
local opts = { noremap = true, silent = true } -- Toggle relative Number
vim.keymap.set("n", "<leader>rn", function()
	vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative numbers" })

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>") -- Source File
vim.keymap.set("n", "<C-s>", ":write<CR>") -- Save file with CTRL + S
vim.keymap.set("n", "<C-c>", ":%y<CR>", opts) -- Copy all lines in buffer

-- Move left/right in insert mode with CTRL+H/L
-- vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

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

-- CodeCompanion
vim.keymap.set("t", "<Esc><Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>c", function()
	local cli = require("codecompanion.interactions.cli")
	cli.toggle({ agent = "opencode" })
	local instance = cli.last_cli()
	if instance then
		instance:focus()
	end
end, { desc = "CodeCompanion Chat Toggle" })

-- Toggle focus between the current window and the previous window (Code <-> CLI)
vim.keymap.set({ "n", "t" }, "<A-w>", function()
	local mode = vim.api.nvim_get_mode().mode

	-- If we are in the terminal, drop out of insert mode first
	if mode == "t" then
		vim.cmd("stopinsert")
	end

	-- Jump to the previous window
	vim.cmd("wincmd p")

	-- If we just jumped INTO a terminal buffer, auto-start insert mode
	if vim.bo.buftype == "terminal" then
		vim.cmd("startinsert")
	end
end, { desc = "Toggle focus between code and terminal" })

-- Toggle Fullscreen (Maximize/Equalize)
local is_maximized = false
vim.keymap.set({ "n", "t" }, "<leader>z", function()
	local mode = vim.api.nvim_get_mode().mode

	-- Temporarily escape terminal mode to run window commands safely
	if mode == "t" then
		vim.cmd("stopinsert")
	end

	if is_maximized then
		vim.cmd("wincmd =") -- Equalize all windows back to normal
		is_maximized = false
	else
		vim.cmd("wincmd _") -- Maximize height
		vim.cmd("wincmd |") -- Maximize width
		is_maximized = true
	end

	-- If we were originally in terminal mode, resume typing
	if mode == "t" then
		vim.cmd("startinsert")
	end
end, { desc = "Toggle fullscreen for current window" })

-- Diagnostics

-- Toggle LSP diagnostics visibility
-- local isLspDiagnosticsVisible = true
-- vim.keymap.set("n", "<C-x>", function()
-- 	isLspDiagnosticsVisible = not isLspDiagnosticsVisible
-- 	vim.diagnostic.config({
-- 		virtual_text = isLspDiagnosticsVisible,
-- 		underline = isLspDiagnosticsVisible,
-- 	})
-- end, { desc = "Toggle LSP diagnostics" })

vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list (location)" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Open diagnostics list (quickfix)" })

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go To Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP Go To References" })
vim.keymap.set("v", "<space>ga", vim.lsp.buf.code_action, { desc = "LSP Code Action (Range)" })
vim.keymap.set("n", "<space>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggal inlay hints" })

-- Unlink/Exit the current snippet (stops <Tab> from jumping)
vim.keymap.set({ "i", "s" }, "<C-c>", function()
	if require("luasnip").in_snippet() then
		require("luasnip").unlink_current()
	end
	return "<Esc>" -- Still perform the normal Escape behavior
end, { expr = true, desc = "Exit snippet and insert mode" })

-- Namu
vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
	desc = "Jump to LSP symbol",
	silent = true,
})
vim.keymap.set("n", "<leader>sw", ":Namu workspace<cr>", {
	desc = "LSP Symbols - Workspace",
	silent = true,
})

-- Snacks
vim.keymap.set("n", "<space>en", function()
	require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
end)
vim.keymap.set("n", "grr", require("snacks").picker.lsp_references, { desc = "Find LSP References" })
vim.keymap.set("n", "gi", require("snacks").picker.lsp_implementations, { desc = "Find LSP References" })
vim.keymap.set("n", "<space>ff", require("snacks").picker.files, { desc = "Find files" })
vim.keymap.set("n", "<space>fs", require("snacks").picker.smart, { desc = "Smart Find files" })
vim.keymap.set("n", "<space>fo", require("snacks").picker.recent, { desc = "Find Recent files" })
vim.keymap.set("n", "<space>fg", require("snacks").picker.git_files, { desc = "Find Git files" })
vim.keymap.set("n", "<space>sb", require("snacks").picker.lines, { desc = "Buffer Lines" })
vim.keymap.set("n", "<space>fw", require("snacks").picker.grep, { desc = "Grep" })
vim.keymap.set("n", "<space>km", require("snacks").picker.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<space>lg", function()
	require("snacks").lazygit()
end, { desc = "Lazygit" })

-- =============================================================================
-- FUNCTIONS & CUSTOM TOOLS
-- =============================================================================
local functions = require("config.core.functions")

-- Map <leader>rr to the run_code function imported above
vim.keymap.set("n", "<leader>rr", functions.run_code, { desc = "Save and Run Code in Kitty" })

-- -- Grep
-- { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
-- { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
-- { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" }
