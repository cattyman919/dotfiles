-- Configs
vim.opt.shiftwidth = 2 -- Or your preferred number of spaces
vim.opt.tabstop = 2 -- It's also common to set tabstop to the same value
vim.opt.expandtab = true -- Ensure tabs are converted to spaces
vim.opt.clipboard = "unnamedplus" -- Allow system clipboards
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.helpheight = 0
vim.opt.laststatus = 3
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Diagnostics
vim.diagnostic.config({
	-- Show signs in the gutter
	signs = {
		active = true,
		-- text = {
		--   [vim.diagnostic.severity.ERROR] = "", -- Icon for Error
		--   [vim.diagnostic.severity.WARN] = "", -- Icon for Warning
		--   [vim.diagnostic.severity.INFO] = "", -- Icon for Info
		--   [vim.diagnostic.severity.HINT] = "", -- Icon for Hint
		-- },
	}, -- or a table to customize (see below)

	-- Show virtual text (inline messages)
	virtual_text = true, -- or a table to customize (see below)

	-- Underline the diagnostic'd text
	underline = true,

	-- Update diagnostics in insert mode (can be distracting for some)
	update_in_insert = false,

	-- Sort diagnostics by severity
	severity_sort = true,

	-- Configure the floating window for diagnostics (e.g., when using vim.diagnostic.open_float())
	float = {
		focusable = false, -- Whether the float window can receive focus
		style = "minimal", -- "minimal" or "border" (deprecated in favor of border option)
		border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
		source = "always", -- "always", "if_many" (show source only if multiple sources) or false
		header = "", -- Text to put at the top of the float
		prefix = "", -- Text to put before each diagnostic in the float
		-- scope = "cursor", -- "cursor", "line", "buffer" (for vim.diagnostic.open_float)
	},
})
