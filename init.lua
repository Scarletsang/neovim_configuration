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
vim.keymap.set('t', '<C-c>', [[<C-c><C-\><C-n>:close<CR>]])
-- vim.keymap.set("n", "<leader>s", ":vsplit<CR>")
-- vim.keymap.set("n", "<leader>c", ":close<CR>")
-- Control W + hjkl to move between windows
-- Control W + c to close window
-- Control W + v to vsplit

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
require('lazy').setup({
  spec = {
    {
      'rose-pine/neovim', as = 'rose-pine',
      config = function()
        vim.cmd('colorscheme rose-pine')
      end
    },
    {'nvim-lua/plenary.nvim'},
-- `gcc` - Toggles the current line using linewise comment
-- `gbc` - Toggles the current line using blockwise comment
-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
    {'numToStr/Comment.nvim', opts = {}, lazy = false},
    {'theprimeagen/harpoon', branch = 'harpoon2', dependencies = {'nvim-lua/plenary.nvim'},
      keys = {
        {"<leader>a", nil},
        {"<C-e>", nil},
        {"<C-h>", nil},
        {"<C-t>", nil},
        {"<C-n>", nil},
        {"<C-s>", nil},
        {"<C-S-P>", nil},
        {"<C-S-N>", nil},
      },
      config = function()
        local harpoon = require("harpoon")
        -- REQUIRED
        harpoon:setup()
        -- REQUIRED
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
      end
    },
    {'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = { 'rafamadriz/friendly-snippets' },

      -- use a release tag to download pre-built binaries
      version = '1.*',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
          preset = 'default',
          ['<Tab>'] = { 'select_next', 'fallback' },
          ['<S-Tab>'] = { 'select_prev', 'fallback' },
          ['<CR>'] = { 'accept', 'fallback' },
        },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono',
          kind_icons = {
            Text = 'txt',
            Method = 'meth',
            Function = 'func',
            Constructor = 'init',

            Field = '->',
            Variable = 'var',
            Property = '->',

            Class = 'class',
            Interface = 'i/f',
            Struct = 'struct',
            Module = 'module',

            Unit = 'unit',
            Value = 'val',
            Enum = 'enum',
            EnumMember = 'enumm',

            Keyword = 'keyword',
            Constant = 'const',

            Snippet = 'sn',
            Color = 'col',
            File = 'file',
            Reference = 'ref',
            Folder = 'dir',
            Event = 'event',
            Operator = 'op',
            TypeParameter = 'type',
          },
        },
        signature = { enabled = true },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
          documentation = { auto_show = false },
          menu = { draw = {
            treesitter = {'lsp'},
          }},
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
    },
    {'neovim/nvim-lspconfig',
      dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'saghen/blink.cmp',
        'j-hui/fidget.nvim',
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = {"clangd"}
        })
        require("fidget").setup({})
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local lspconfig = require('lspconfig')
        lspconfig['clangd'].setup({ capabilities = capabilities })
        lspconfig['ols'].setup({ capabilities = capabilities })
        lspconfig['lua_ls'].setup({
          capabilities = capabilities,
          settings = { Lua = { runtime = { version = "Lua 5.1" }, diagnostics = { globals = { 'vim' }}}},
        })
        vim.diagnostic.config({
          -- update_in_insert = true,
          float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        })
        -- Mappings.
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        -- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
      end
    },
    {'nvim-telescope/telescope.nvim',
      tag = '0.1.6',
      -- or                            , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('telescope').setup({
         pickers = {
          find_files = {theme = "ivy"},
          help_tags = {theme = "ivy"},
          live_grep = {theme = "ivy"},
          buffers = {theme = "ivy"},
          lsp_references = {theme = "ivy"},
        }
        })
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>f', builtin.find_files, {})
        vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
        -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        -- vim.keymap.set('n', '<leader>pws', function()
        --   local word = vim.fn.expand("<cword>")
        --   builtin.grep_string({ search = word })
        -- end)
        -- vim.keymap.set('n', '<leader>pWs', function()
        --   local word = vim.fn.expand("<cWORD>")
        --   builtin.grep_string({ search = word })
        -- end)
        -- vim.keymap.set('n', '<leader>ps', function()
        --   builtin.grep_string({ search = vim.fn.input("Grep > ") })
        -- end)
      end
    },
    {'nvim-treesitter/nvim-treesitter',
      run = ":TSEnable",
      config = function()
        require'nvim-treesitter.configs'.setup {
          -- A list of parser names, or "all" (the five listed parsers should always be installed)
          ensure_installed = {
            "c",
            "cpp",
            "rust",
            "lua",
            "vim", "vimdoc",
            "query",
            "diff",
            "make", "cmake",
            "markdown",
            "glsl",
            "odin",
          },
          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,
          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = false,
          -- List of parsers to ignore installing (or "all")
          ignore_install = { "javascript", "python" },
          ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
          -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
          highlight = {
            enable = true,
            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- disable = { "c", "rust" },
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
          },
        }
      end
    },
    {'nvim-treesitter/nvim-treesitter-context',
      dependencies = {"nvim-treesitter/nvim-treesitter"},
      run = ":TSContextEnable",
      config = function()
        local treesitter_context = require('treesitter-context')
        treesitter_context.setup{
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 20, -- Maximum number of lines to show for a single context
          trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20, -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        }
        vim.keymap.set("n", "[c", function()
          treesitter_context.go_to_context(vim.v.count1)
        end, { silent = true })
      end
    },
    {'mbbill/undotree',
      keys = {
        {"<leader>u", vim.cmd.UndotreeToggle},
      }
    },
    {'akinsho/toggleterm.nvim', version = "*",
      config = function()
        local toggleterm = require("toggleterm")
        toggleterm.setup{
          auto_scroll = true,
          size = 5,
        }
        vim.keymap.set("n", "<leader>t", function()
          toggleterm.exec(vim.fn.input("Command > "), nil, nil, nil, nil, nil, false)
        end)
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
          cmd = "lazygit",
          dir = "git_dir",
          direction = "float",
          -- function to run on opening the terminal
          on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
          end,
          -- function to run on closing the terminal
          on_close = function(_)
            vim.cmd("startinsert!")
          end,
        })

        local function lazygit_toggle()
          lazygit:toggle()
        end
        vim.keymap.set("n", "<leader>gg", lazygit_toggle)
      end,
    },
    -- {'tpope/vim-fugitive',
    --   config = function()
    --     vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    --   end
    -- },
	}
})
