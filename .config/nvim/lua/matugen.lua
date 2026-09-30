 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#19120c',
    base01 = '#261e18',
    base02 = '#312822',
    base03 = '#9e8e82',
    base04 = '#d6c3b6',
    base05 = '#efe0d5',
    base06 = '#efe0d5',
    base07 = '#efe0d5',
    base08 = '#ffb4ab',
    base09 = '#c3cb98',
    base0A = '#e2c0a5',
    base0B = '#ffb778',
    base0C = '#c3cb98',
    base0D = '#ffb778',
    base0E = '#e2c0a5',
    base0F = '#ffdcc1',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#efe0d5',          bg = '#19120c' })
  hi('TelescopeBorder',         { fg = '#9e8e82',             bg = '#19120c' })
  hi('TelescopePromptNormal',   { fg = '#efe0d5',          bg = '#19120c' })
  hi('TelescopePromptBorder',   { fg = '#9e8e82',             bg = '#19120c' })
  hi('TelescopePromptPrefix',   { fg = '#ffb778',             bg = '#19120c' })
  hi('TelescopePromptCounter',  { fg = '#d6c3b6',  bg = '#19120c' })
  hi('TelescopePromptTitle',    { fg = '#19120c',             bg = '#ffb778' })
  hi('TelescopePreviewTitle',   { fg = '#19120c',             bg = '#e2c0a5' })
  hi('TelescopeResultsTitle',   { fg = '#19120c',             bg = '#c3cb98' })
  hi('TelescopeSelection',      { fg = '#efe0d5',          bg = '#312822' })
  hi('TelescopeSelectionCaret', { fg = '#ffb778',             bg = '#312822' })
  hi('TelescopeMatching',       { fg = '#ffb778',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#efe0d5',          bg = '#19120c' })
  hi('MiniPickBorder',         { fg = '#9e8e82',             bg = '#19120c' })
  hi('MiniPickPrompt',   { fg = '#efe0d5',          bg = '#19120c' })
  hi('MiniPickPromptPrefix',   { fg = '#ffb778',             bg = '#19120c' })
  hi('MiniPickBorderText',    { fg = '#19120c',             bg = '#ffb778' })
  hi('MiniPickMatchCurrent',      { fg = '#efe0d5',          bg = '#312822' })
  hi('MiniPickPromptCaret', { fg = '#ffb778',             bg = '#312822' })
  hi('MiniPickMatchRanges',       { fg = '#ffb778',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
