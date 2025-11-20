-- Auto window layout plugin
-- Provides keymaps for arranging windows in specific ratios

-- Define predefined ratios for different window counts
local columns_ratios_config = {
  [2] = { 1, 4 },
  [3] = { 1, 3, 2 },
}

-- Layout auto column based on window count
vim.keymap.set('n', '<leader>lac', function()
  local total_width = vim.o.columns
  local win_count = vim.fn.winnr '$'

  -- Get ratios from config or use equal distribution
  local ratios = columns_ratios_config[win_count]
  if not ratios then
    -- Equal distribution for undefined counts
    ratios = {}
    for i = 1, win_count do
      ratios[i] = 1
    end
  end

  -- Calculate total ratio sum
  local ratio_sum = 0
  for _, ratio in ipairs(ratios) do
    ratio_sum = ratio_sum + ratio
  end

  -- Calculate and apply widths for each window
  for i = 1, win_count do
    local width = math.floor(total_width * ratios[i] / ratio_sum)
    vim.cmd(i .. 'wincmd w')
    vim.cmd('vertical resize ' .. width)
  end
end, { desc = 'Layout auto column' })

-- Setup which-key group if available
local ok, wk = pcall(require, 'which-key')
if ok then
  wk.add {
    { '<leader>l', group = '[L]ayout' },
    { '<leader>la', group = 'Layout [A]uto' },
    { '<leader>lac', desc = '[C]olumns' },
  }
end

return {}
