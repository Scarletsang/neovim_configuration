return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  -- or                            , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {'<leader>pf', require('telescope.builtin').find_files},
    {'<C-p>', require('telescope.builtin').git_files},
    {'<leader>ps', function()
      require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
    end},
  },
}
