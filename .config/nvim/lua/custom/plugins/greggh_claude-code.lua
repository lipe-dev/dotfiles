return {
  'greggh/claude-code.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for git operations
  },
  config = function()
    require('claude-code').setup {
      keymaps = {
        toggle = {
          normal = '<leader>cc',
          terminal = false,
        },
      },
      window = {
        position = 'vertical',  -- Opens as a side split
        split_ratio = 0.3,      -- 30% of screen width
      },
    }
  end,
}
