-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "lua_ls", "tsserver", "pyright", 
          "rust_analyzer", "gopls" 
        },
        automatic_installation = true,
      })

      -- Configure diagnostics
      vim.diagnostic.config({
        signs = true,
        virtual_text = true,
        update_in_insert = false,
        severity_sort = true,
      })

      local lspconfig = require("lspconfig")
      
      -- Lua LSP
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- TypeScript/JavaScript LSP
      lspconfig.tsserver.setup({})
      
      -- Python LSP
      lspconfig.pyright.setup({})
      
      -- Rust LSP
      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
          },
        },
      })

      -- Go LSP
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      -- LSP Key mappings
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format file" })
    end,
  },
}
