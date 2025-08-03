-- ~/.config/nvim/lua/plugins/languages.lua
return {
  -- Rust tools
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
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
        goimport = 'gopls', -- if set to 'gopls' will use golsp format
        gofmt = 'gopls', -- if set to gopls will use golsp format
        max_line_len = 120,
        tag_transform = false,
        test_dir = '',
        comment_placeholder = '   ',
        lsp_cfg = true, -- false: use your own lspconfig
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true, -- use on_attach from go.nvim
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
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
}
