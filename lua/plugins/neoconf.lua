return {
  -- Manage LSP project-local and global configuration
  'folke/neoconf.nvim',
  priority = 100, -- Load before other plugins
  config = function()
    require('neoconf').setup({
      -- override any of the default settings here
    })
  end,
}