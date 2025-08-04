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
          "lua_ls", "tsserver", "pyright"
          -- REMOVED: "rust_analyzer", "gopls" - handled by specialized plugins
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for most servers
          function(server_name)
            -- Skip servers handled by specialized plugins
            if server_name == "rust_analyzer" or server_name == "gopls" then
              return
            end
            require("lspconfig")[server_name].setup({})
          end,
          
          -- Explicitly disable rust_analyzer - rustaceanvim handles it
          ["rust_analyzer"] = function() end,
          
          -- Explicitly disable gopls - go.nvim handles it  
          ["gopls"] = function() end,
          
          -- Custom setup for specific servers
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,
          
          ["tsserver"] = function()
            require("lspconfig").tsserver.setup({})
          end,
          
          ["pyright"] = function()
            require("lspconfig").pyright.setup({})
          end,
        },
      })
      
      -- Configure diagnostics
      vim.diagnostic.config({
        signs = true,
        virtual_text = true,
        update_in_insert = false,
        severity_sort = true,
      })
      
      -- REMOVED: Manual lspconfig setups for rust_analyzer and gopls
      -- These are now handled by rustaceanvim and go.nvim respectively
      
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
