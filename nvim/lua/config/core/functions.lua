local M = {}

-- Helper: Find the ID of the active window in the "other" tab
local function get_runner_window_id()
	-- 1. Get the current Kitty state as JSON
	local handle = io.popen("kitten @ ls")
	if not handle then
		return nil
	end
	local json_str = handle:read("*a")
	handle:close()

	-- 2. Parse JSON and get our current ID
	local data = vim.json.decode(json_str)
	local my_id = tonumber(vim.env.KITTY_WINDOW_ID)

	-- 3. Iterate through the OS Window to find tabs
	for _, os_win in ipairs(data) do
		local tabs = os_win.tabs
		local my_tab_index = nil

		-- Find which tab *we* (Neovim) are inside
		for i, tab in ipairs(tabs) do
			for _, win in ipairs(tab.windows) do
				if win.id == my_id then
					my_tab_index = i
					break
				end
			end
		end

		-- 4. Find the "Other" tab
		if my_tab_index then
			for i, tab in ipairs(tabs) do
				-- If this tab is NOT the one Neovim is in...
				if i ~= my_tab_index then
					-- ...Then this is our Runner tab.
					local history = tab.active_window_history
					if history and #history > 0 then
						return history[#history]
					elseif #tab.windows > 0 then
						return tab.windows[1].id
					end
				end
			end
		end
	end
	return nil
end

M.run_code = function()
	-- 1. Safety Checks
	if not vim.env.KITTY_LISTEN_ON then
		vim.notify("❌ Not in Kitty.", vim.log.levels.ERROR)
		return
	end

	-- 2. Save
	vim.cmd("write")

	-- 3. Prepare Command
	local filetype = vim.bo.filetype
	local cmd = ""

	if filetype == "go" then
		cmd = "go run ."
	elseif filetype == "rust" then
		cmd = "cargo run"
	elseif filetype == "zig" then
		cmd = "zig build run"
	elseif vim.fn.filereadable("Makefile") == 1 then
		cmd = "make run"
	else
		vim.notify("⚠️ No run command for " .. filetype, vim.log.levels.WARN)
		return
	end

	-- 4. Get the exact ID of the other tab
	local target_id = get_runner_window_id()

	if not target_id then
		vim.notify("❌ Could not find the other tab!", vim.log.levels.ERROR)
		return
	end

	-- 5. Send Text & Focus
	local kitty_payload = string.format("clear && %s\r", cmd)
	local safe_cmd = string.format("kitten @ send-text --match id:%d --stdin", target_id)

	local handle = io.popen(safe_cmd, "w")
	if handle then
		handle:write(kitty_payload)
		handle:close()

		-- === NEW LINE: Switch focus to that window ===
		os.execute(string.format("kitten @ focus-window --match id:%d", target_id))

	-- Optional: No notification needed since you'll see the screen switch
	else
		vim.notify("❌ Failed to send command", vim.log.levels.ERROR)
	end
end

return M
