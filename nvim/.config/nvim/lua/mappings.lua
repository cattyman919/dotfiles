require "nvchad.mappings"


local map = vim.keymap.set
local builtin = require('telescope.builtin')

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- Focus to center when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

-- Telescope 
map("n", "<leader>fs", builtin.lsp_document_symbols, {desc = "Telescope Symbol Picker"})
map("n", "<leader>ds", builtin.diagnostics, {desc = "Telescope Diagnostics Picker"})
map("n", "<leader>ts", builtin.treesitter, {desc = "Telescope Treesitter Picker"})
map("n", "<leader>cs", builtin.commands, {desc = "Telescope Command Picker"})

-- TMUX
map("n", "<C-h>", " <cmd> TmuxNavigateLeft<CR>", {desc = "Window Left"})
map("n", "<C-l>", " <cmd> TmuxNavigateRight<CR>", {desc = "Window Right"})
map("n", "<C-j>", " <cmd> TmuxNavigateDown<CR>", {desc = "Window Down"})
map("n", "<C-k>", " <cmd> TmuxNavigateUp<CR>", {desc = "Window Up"})
