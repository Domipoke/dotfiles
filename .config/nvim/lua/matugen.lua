 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#152728',
    base01 = '#234143',
    base02 = '#1f3a3c',
    base03 = '#61716f',
    base04 = '#afb6b6',
    base05 = '#f2f3f3',
    base06 = '#f2f3f3',
    base07 = '#f2f3f3',
    base08 = '#fd4663',
    base09 = '#9399db',
    base0A = '#8cbfe2',
    base0B = '#85e9e1',
    base0C = '#969de9',
    base0D = '#93ece4',
    base0E = '#96c7e9',
    base0F = '#bedef4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f3f3',          bg = '#152728' })
  hi('TelescopeBorder',         { fg = '#61716f',             bg = '#152728' })
  hi('TelescopePromptNormal',   { fg = '#f2f3f3',          bg = '#152728' })
  hi('TelescopePromptBorder',   { fg = '#61716f',             bg = '#152728' })
  hi('TelescopePromptPrefix',   { fg = '#85e9e1',             bg = '#152728' })
  hi('TelescopePromptCounter',  { fg = '#afb6b6',  bg = '#152728' })
  hi('TelescopePromptTitle',    { fg = '#152728',             bg = '#85e9e1' })
  hi('TelescopePreviewTitle',   { fg = '#152728',             bg = '#8cbfe2' })
  hi('TelescopeResultsTitle',   { fg = '#152728',             bg = '#9399db' })
  hi('TelescopeSelection',      { fg = '#f2f3f3',          bg = '#1f3a3c' })
  hi('TelescopeSelectionCaret', { fg = '#85e9e1',             bg = '#1f3a3c' })
  hi('TelescopeMatching',       { fg = '#85e9e1',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f3f3',          bg = '#152728' })
  hi('MiniPickBorder',         { fg = '#61716f',             bg = '#152728' })
  hi('MiniPickPrompt',   { fg = '#f2f3f3',          bg = '#152728' })
  hi('MiniPickPromptPrefix',   { fg = '#85e9e1',             bg = '#152728' })
  hi('MiniPickBorderText',    { fg = '#152728',             bg = '#85e9e1' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f3f3',          bg = '#1f3a3c' })
  hi('MiniPickPromptCaret', { fg = '#85e9e1',             bg = '#1f3a3c' })
  hi('MiniPickMatchRanges',       { fg = '#85e9e1',             bold = true })
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
