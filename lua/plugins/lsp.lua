-- lsp.lua - Complete LSP and Completion configuration

return {
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local lspconfig = require('lspconfig')
      
      -- Enhanced capabilities for completion
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      
      -- Enhanced completion capabilities
      capabilities.textDocument.completion.completionItem = {
        documentationFormat = { 'markdown', 'plaintext' },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
          },
        },
      }

      -- Common LSP on_attach function
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Keybindings for LSP
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, bufopts)
      end

      -- LSP UI improvements
      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          spacing = 4,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      -- Language server configurations
      -- Note: Rust is handled by rustaceanvim, not lspconfig

      -- Go LSP
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            matcher = "fuzzy",
            experimentalWorkspaceModule = true,
          },
        },
      })

      -- TypeScript/JavaScript LSP
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          typescript = {
            preferences = {
              completionStyle = "detailed",
              importModuleSpecifier = "shortest",
            },
          },
          javascript = {
            preferences = {
              completionStyle = "detailed",
            },
          },
        },
      })

      -- Lua LSP (for Neovim config)
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      -- Python LSP
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- JSON LSP
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      })
    end,
  },

  -- Mason for LSP server management
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'gopls',
          'ts_ls',
          'lua_ls',
          'pyright',
          'jsonls',
          -- rust_analyzer is managed by rustaceanvim, not mason
        },
        automatic_installation = true,
      })
    end,
  },

  -- nvim-cmp: Main completion plugin
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Completion sources
      'hrsh7th/cmp-nvim-lsp',        -- LSP completion
      'hrsh7th/cmp-buffer',          -- Buffer completion
      'hrsh7th/cmp-path',            -- File path completion
      'hrsh7th/cmp-cmdline',         -- Command line completion
      'hrsh7th/cmp-nvim-lua',        -- Neovim Lua API completion
      
      -- Snippets
      'L3MON4D3/LuaSnip',            -- Snippet engine
      'saadparwaiz1/cmp_luasnip',    -- LuaSnip completion source
      'rafamadriz/friendly-snippets', -- Collection of snippets
      
      -- Icons
      'onsails/lspkind.nvim',        -- VS Code-like pictograms
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')
      
      -- Load snippets from friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()
      
      -- Helper function for checking if we can expand or jump
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        
        mapping = cmp.mapping.preset.insert({
          -- Basic navigation
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          
          -- Tab/Shift-Tab for completion and snippet navigation
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },    -- LSP completion (highest priority)
          { name = 'luasnip' },     -- Snippets
          { name = 'nvim_lua' },    -- Neovim Lua API
        }, {
          { name = 'buffer' },      -- Buffer text (lower priority)
          { name = 'path' },        -- File paths
        }),
        
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(entry, vim_item)
              -- Add source name to the completion item
              vim_item.menu = ({
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                buffer = '[Buffer]',
                path = '[Path]',
                nvim_lua = '[Lua]',
              })[entry.source.name]
              return vim_item
            end,
          }),
        },
        
        experimental = {
          ghost_text = true, -- Show preview of completion as ghost text
        },
      })

      -- Command line completion
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      -- Search completion
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
    end,
  },

  -- Autopairs - automatically close brackets, quotes, etc.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local autopairs = require('nvim-autopairs')
      autopairs.setup({
        check_ts = true, -- Use treesitter
        ts_config = {
          lua = { 'string', 'source' },
          javascript = { 'string', 'template_string' },
        },
        disable_filetype = { 'TelescopePrompt' },
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
          offset = 0,
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'PmenuSel',
          highlight_grey = 'LineNr'
        },
      })

      -- Integration with nvim-cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- Rust-specific tools (rustaceanvim handles LSP configuration)
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- Add tools configuration if needed
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- Use the same on_attach function as other LSP servers
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<space>f', function()
              vim.lsp.buf.format { async = true }
            end, bufopts)
          end,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = true, -- Fixed: should be boolean, not table
              procMacro = {
                enable = true,
              },
              completion = {
                autoimport = {
                  enable = true,
                },
                callable = {
                  snippets = "fill_arguments",
                },
              },
            },
          },
        },
        -- DAP configuration
        dap = {
          -- Add DAP configuration if needed
        },
      }
    end,
  },
}
