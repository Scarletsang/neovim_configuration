return {
  'tpope/vim-fugitive',
  setup = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
  end,
}
