return {
  {
    'nvim-java/nvim-java',
    ft = { 'java' },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'mfussenegger/nvim-dap',
      {
        'mason-org/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      },
    },
    config = function()
      require('java').setup({
        jdk = { auto_install = false },
      })
      vim.lsp.enable('jdtls')
    end,
  },
}
