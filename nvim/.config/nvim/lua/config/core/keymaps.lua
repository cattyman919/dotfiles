-- Keymaps
local opts = { noremap = true, silent = true }

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

-- Navigations (Hop Plugin)
vim.keymap.set("n", "<C-f>", ":HopWord<CR>", { desc = "move down in buffer with cursor centered" })

-- Harpoon
local harpoon = require("harpoon")
local fidget = require("fidget")

-- Add Harpoon Mark
vim.keymap.set("n", "<leader>a", function()
	local fname = vim.fn.expand("%:t") -- current file name
	-- Notify
	fidget.notify("Added " .. fname .. " Harpoon", vim.log.levels.INFO)

	harpoon:list():add()
end)

-- Remove Harpoon Mark
vim.keymap.set("n", "<leader>r", function()
	local fname = vim.fn.expand("%:t") -- current file name
	-- Notify
	fidget.notify("Removed " .. fname .. " Harpoon", vim.log.levels.WARN)

	harpoon:list():remove()
end)

-- Open Harpoon List with telescope
vim.keymap.set("n", "<C-e>", function()
	-- basic telescope configuration
	local conf = require("telescope.config").values
	local ivy = require("telescope.themes").get_ivy

	local function toggle_telescope(harpoon_files)
		local file_paths = {}
		for _, item in ipairs(harpoon_files.items) do
			table.insert(file_paths, item.value)
		end

		require("telescope.pickers")
			.new(
				{},
				ivy({
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
			)
			:find()
	end

	toggle_telescope(harpoon:list())
end)

-- Toggle next in harpoon list (wrap)
vim.keymap.set("n", "<C-V>", function()
	harpoon:list():next({
		ui_nav_wrap = true,
	})
end)

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
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP Code Action" })
vim.keymap.set("n", "<space>ga", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
vim.keymap.set("n", "<space>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggal inlay hints" })

-- Navbuddy
local navbuddy = require("nvim-navbuddy")
vim.keymap.set("n", "<space>sd", navbuddy.open, { desc = "Nav Buddy" })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Find references" })
vim.keymap.set("n", "<space>sw", builtin.lsp_dynamic_workspace_symbols, { desc = "Dynamic Workspace Symbols" })
vim.keymap.set("n", "<space>fh", builtin.help_tags, { desc = "Find help tags" })
vim.keymap.set("n", "<space>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<space>fo", builtin.oldfiles, { desc = "Find old files" })
vim.keymap.set("n", "<space>fj", builtin.jumplist, { desc = "Find jump list" })
vim.keymap.set("n", "<space>fw", builtin.live_grep, { desc = "Live Grep" })

-- Telescope to Neovim Config Files
vim.keymap.set("n", "<space>en", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("config"),
	})
end)

-- Terminals
vim.keymap.set("n", "<space>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 5)
end, { desc = "Open small terminal at bottom" })
