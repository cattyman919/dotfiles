return {
	"vyfor/cord.nvim",
	build = ":Cord update",
	opts = {
		editor = {
			tooltip = "Banger Editor",
		},
		display = {
			theme = "atom",
			flavor = "accent",
			swap_icons = false,
		},
		idle = {
			details = function(opts)
				return string.format("Taking a break from %s", opts.filename)
			end,
		},
		advanced = {
			discord = {
				reconnect = {
					enabled = true,
				},
				pipe_paths = {
					(os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000") .. "/app/com.discordapp.Discord/discord-ipc-0",
				},
			},
		},
	},
}
