vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.listchars = "tab:. ,trail:~,extends:>,precedes:<"
vim.opt.list = true

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
