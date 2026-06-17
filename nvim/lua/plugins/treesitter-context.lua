return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    enable = true, -- Enable this plugin (Can be toggled with :TSContextToggle)
    max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded
    mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil,          -- Separator between context and content. Use a single character, e.g., '-'
    zindex = 20,              -- The Z-index of the context window
  }
}
