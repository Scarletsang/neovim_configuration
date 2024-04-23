return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    --- uncomment these if you want to manage the language servers from neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- lsp support
    'neovim/nvim-lspconfig',
    -- autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'l3mon4D3/luasnip',
  },
  config = function()
    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp_zero.default_keymaps({buffer = bufnr})
    end)

    -- here you can setup the language servers 

    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
      'clangd',
      'rust_analyzer'
      },
      handlers = {
        lsp_zero.default_setup,
      },
    })
    
  end,
}
