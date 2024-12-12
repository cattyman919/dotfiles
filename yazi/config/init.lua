require("omp"):setup()
require("full-border"):setup()
require("git"):setup()
--
require("projects"):setup({
	save = {
		method = "lua", -- yazi | lua
	},
	last = {
		update_after_save = true,
		update_after_load = true,
		load_after_start = false,
	},
	merge = {
		quit_after_merge = false,
	},
	notify = {
		enable = true,
		title = "Projects",
		timeout = 3,
		level = "info",
	},
})

--- @sync entry
return {
	entry = function()
		local h = cx.active.current.hovered
		ya.manager_emit("tab_create", h and h.cha.is_dir and { h.url } or { current = true })
	end,
}
