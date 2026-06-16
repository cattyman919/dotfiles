return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")

		-- Set the icons for the fold column natively in Neovim
		vim.opt.fillchars:append({
			foldopen = "", -- Icon for an open fold
			foldclose = "", -- Icon for a closed fold
			foldsep = " ", -- Character for the fold separator
			fold = " ", -- Character for the fold line itself (blank for clean look)
		})

		-- Ensure Neovim allocates at least 1 column for folds
		vim.opt.foldcolumn = "1"

		require("statuscol").setup({
			relculright = true,
			segments = {
				-- 1. Diagnostics and standard signs
				{
					sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
					click = "v:lua.ScSa",
				},
				-- 2. Line numbers
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				-- 3. The fold column (uses the fillchars defined above)
				{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
				-- 4. Git signs or other miscellaneous signs
				{
					sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
					click = "v:lua.ScSa",
				},
			},
		})
	end,
}
