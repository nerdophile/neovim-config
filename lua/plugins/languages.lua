-- lua/plugins/languages.lua - Rust & Go specific tools
-- ====================================================

return {
  -- Go tools
  {
    'ray-x/go.nvim',
    dependencies = {  -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
      
      -- Go keymaps
      vim.keymap.set('n', '<leader>gr', ':GoRun<CR>', { desc = '[G]o [R]un' })
      vim.keymap.set('n', '<leader>gt', ':GoTest<CR>', { desc = '[G]o [T]est' })
      vim.keymap.set('n', '<leader>gb', ':GoBuild<CR>', { desc = '[G]o [B]uild' })
      vim.keymap.set('n', '<leader>gi', ':GoInstall<CR>', { desc = '[G]o [I]nstall' })
      vim.keymap.set('n', '<leader>gf', ':GoFmt<CR>', { desc = '[G]o [F]ormat' })
      vim.keymap.set('n', '<leader>gd', ':GoDoc<CR>', { desc = '[G]o [D]oc' })
    end,
    event = {'CmdlineEnter'},
    ft = {'go', 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -- Rust tools
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      -- Rust keymaps
      vim.keymap.set('n', '<leader>rr', ':RustLsp runnables<CR>', { desc = '[R]ust [R]unnables' })
      vim.keymap.set('n', '<leader>rt', ':RustLsp testables<CR>', { desc = '[R]ust [T]estables' })
      vim.keymap.set('n', '<leader>rd', ':RustLsp debuggables<CR>', { desc = '[R]ust [D]ebuggables' })
      vim.keymap.set('n', '<leader>rc', ':RustLsp openCargo<CR>', { desc = '[R]ust Open [C]argo.toml' })
    end,
  },
}
