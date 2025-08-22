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
