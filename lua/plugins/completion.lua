-- completion.lua - Enhanced autocomplete configuration for Neovim

return {
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

  -- Enhanced LSP capabilities for better completion
  {
    'neovim/nvim-lspconfig',
    opts = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      
      return {
        capabilities = capabilities,
        -- Add other LSP config here
      }
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

  -- Better syntax highlighting for better completion context
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua', 'rust', 'go', 'javascript', 'typescript',
          'python', 'json', 'yaml', 'toml', 'markdown',
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = '<C-s>',
            node_decremental = '<C-backspace>',
          },
        },
      })
    end,
  },
}
