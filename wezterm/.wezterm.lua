local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.default_prog = { 'yazi' }
config.window_close_confirmation = 'NeverPrompt'

config.font = wezterm.font 'JetBrains Mono'
-- config.color_scheme = 'Ayu Dark (Gogh)'
-- config.color_scheme = 'ayu'

config.window_frame = {
  font = wezterm.font { family = 'JetBrains Mono', weight = 'Bold' },
  font_size = 10.0,
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333',
}

config.colors = {
  tab_bar = {
    inactive_tab_edge = '#575757',
  },
}

config.keys = {
  { key = 'q', mods = 'CTRL|SHIFT', action = wezterm.action.QuitApplication },
  {
    key = 'R',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  {
    key = 'N',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
    {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = false },
  },
  { key = 'o', mods = 'CTRL|SHIFT', action = wezterm.action.ShowTabNavigator },
}

wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime '%-d %b  %H:%M '

  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = '  🔋' .. string.format('%.0f%%', b.state_of_charge * 100)
  end

  window:set_right_status(wezterm.format {
    { Text = window:active_workspace() .. bat .. '   ' .. date },
  })
end)

return config
