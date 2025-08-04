-- ~/.config/nvim/lua/plugins/lsp.lua (Safe version without handler conflicts)
return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup Mason first
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
                  diagnostics = { 
                    globals = { "vim" },
                    -- Make diagnostics faster
                    neededFileStatus = {
                      ["codestyle-check"] = "Any",
                    },
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                  },
                  telemetry = { enable = false },
                },
              },
              flags = {
                debounce_text_changes = 50, -- Faster updates (default is 150ms)
              },
            })
          end,
          
          ["tsserver"] = function()
            require("lspconfig").tsserver.setup({
              flags = {
                debounce_text_changes = 50, -- Faster updates
              },
            })
          end,
          
          ["pyright"] = function()
            require("lspconfig").pyright.setup({
              flags = {
                debounce_text_changes = 50, -- Faster updates
              },
            })
          end,
        },
      })
      
      -- Configure diagnostics for instant feedback
      vim.diagnostic.config({
        signs = true,
        virtual_text = true,
        update_in_insert = true, -- Show diagnostics while typing
        severity_sort = true,
      })
      
      -- Make LSP clients provide faster feedback
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.diagnostic.on_publish_diagnostics, {
          update_in_insert = true,
          virtual_text = true,
        }
      )
      
      -- LSP Key mappings - Enhanced Navigation
      -- Core navigation
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
      
      -- Hover and actions
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format file" })
      
      -- Additional useful keymaps
      vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, { desc = "LSP Hover" })
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type definition" })
      
      -- Signature help while typing (shows function parameters)
      vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
      
      -- Navigation history
      vim.keymap.set("n", "<C-o>", "<C-o>", { desc = "Jump back" })
      vim.keymap.set("n", "<C-i>", "<C-i>", { desc = "Jump forward" })
      
      -- Telescope integration (if you have telescope)
      local ok, builtin = pcall(require, "telescope.builtin")
      if ok then
        vim.keymap.set("n", "gpd", builtin.lsp_definitions, { desc = "Peek definition" })
        vim.keymap.set("n", "gpr", builtin.lsp_references, { desc = "Peek references" })
      end
    end,
  },
}
