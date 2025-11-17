-- Keymaps
local opts = { noremap = true, silent = true }

-- Toggle relative Number
vim.keymap.set("n", "<leader>rn", function()
	vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative numbers" })

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>") -- Source File
vim.keymap.set("n", "<C-s>", ":write<CR>") -- Save file with CTRL + S
vim.keymap.set("n", "<C-c>", ":%y<CR>", opts) -- Copy all lines in buffer

-- Move left/right in insert mode with CTRL+H/L
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

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

-- Telescope
-- vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references, { desc = "Find references" })
-- vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, { desc = "Find implementations" })
-- vim.keymap.set(
-- 	"n",
-- 	"<space>sw",
-- 	require("telescope.builtin").lsp_dynamic_workspace_symbols,
-- 	{ desc = "Dynamic Workspace Symbols" }
-- )
-- vim.keymap.set("n", "<space>sd", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
-- vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags, { desc = "Find help tags" })
-- vim.keymap.set("n", "<space>ff", require("telescope.builtin").find_files, { desc = "Find files" })
-- vim.keymap.set("n", "<space>fg", require("telescope.builtin").git_files, { desc = "Find Git files" })
-- vim.keymap.set("n", "<space>fo", require("telescope.builtin").oldfiles, { desc = "Find old files" })
-- vim.keymap.set("n", "<space>fj", require("telescope.builtin").jumplist, { desc = "Find jump list" })
-- vim.keymap.set("n", "<space>fw", require("telescope.builtin").live_grep, { desc = "Live Grep" })
-- vim.keymap.set("n", "<space>km", require("telescope.builtin").keymaps, { desc = "Keymap" })

-- Telescope to Neovim Config Files
-- vim.keymap.set("n", "<space>en", function()
-- 	require("telescope.builtin").find_files({
-- 		cwd = vim.fn.stdpath("config"),
-- 	})
-- end)

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
vim.keymap.set("n", "<space>fg", require("snacks").picker.git_files, { desc = "Find Git files" })
vim.keymap.set("n", "<space>sb", require("snacks").picker.lines, { desc = "Buffer Lines" })
vim.keymap.set("n", "<space>fw", require("snacks").picker.grep, { desc = "Grep" })
vim.keymap.set("n", "<space>km", require("snacks").picker.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<space>lg", function()
	require("snacks").lazygit()
end, { desc = "Lazygit" })

-- -- Grep
-- { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
-- { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
-- { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" }
