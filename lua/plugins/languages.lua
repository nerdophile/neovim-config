-- ~/.config/nvim/lua/plugins/languages.lua
return {
  -- Rust tools
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    lazy = false, -- Important: don't lazy load
    priority = 1000, -- Load before other LSP plugins
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = { auto_focus = true },
        },
        server = {
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>rr", function()
              vim.cmd.RustLsp('runnables')
            end, { desc = "Rust Runnables", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>dr", function()
              vim.cmd.RustLsp('debuggables')
            end, { desc = "Rust Debuggables", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>ra", function()
              vim.cmd.RustLsp('hover', 'actions')
            end, { desc = "Rust Hover Actions", buffer = bufnr })
          end,
        },
      }
    end,
  },
  -- Go tools  
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimport = 'gopls',
        gofmt = 'gopls', 
        max_line_len = 120,
        tag_transform = false,
        test_dir = '',
        comment_placeholder = '   ',
        lsp_cfg = true, -- Let go.nvim handle gopls
        lsp_gofumpt = true,
        lsp_on_attach = true,
        dap_debug = true,
      })
      
      -- Go-specific keymaps
      vim.keymap.set("n", "<leader>gr", ":GoRun<CR>", { desc = "Go Run" })
      vim.keymap.set("n", "<leader>gt", ":GoTest<CR>", { desc = "Go Test" })
      vim.keymap.set("n", "<leader>gb", ":GoBuild<CR>", { desc = "Go Build" })
      vim.keymap.set("n", "<leader>gi", ":GoImport<CR>", { desc = "Go Import" })
      vim.keymap.set("n", "<leader>gf", ":GoFmt<CR>", { desc = "Go Format" })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()'
  },
}
