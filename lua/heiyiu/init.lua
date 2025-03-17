---- settings ----
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.listchars = "tab:. ,trail:~,extends:>,precedes:<"
vim.opt.list = true
vim.api.nvim_set_option("clipboard","unnamed")

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
local os_name = vim.loop.os_uname().sysname
if os_name == 'Darwin' or os_name == 'Linux' then
vim.opt.undodir = os.getenv("HOME") .. "/nvim/.undo"
else
vim.opt.undodir = os.getenv("LOCALAPPDATA") .. "/nvim/.undo"
end
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

---- keymap ----
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "<leader>h", ":Ex<CR>")
vim.keymap.set("n", "<leader>s", ":vsplit<CR>")
vim.keymap.set("n", "<leader>c", ":close<CR>")
-- Control W + hjkl to move between windows

---- lazy package manager ----
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('heiyiu.plugins')
