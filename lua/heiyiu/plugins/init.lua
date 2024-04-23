return {
  {
    'rose-pine/neovim', as = 'rose-pine',
    config = function()
    vim.cmd('colorscheme rose-pine')
    end
  },
  'nvim-treesitter/playground',
  'nvim-lua/plenary.nvim',
}