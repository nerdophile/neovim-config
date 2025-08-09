-- lua/plugins/ui.lua - UI enhancement plugins
-- ============================================

return {
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]o' },
        { '<leader>x', group = 'Trouble' },
        { '<leader>l', group = '[L]SP Lines' },
        { '<leader>b', group = '[B]uffer' },
      }
    end,
  },

  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- Buffer line (tabs)
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup{}
      
      -- Buffer navigation keymaps
      vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { desc = '[B]uffer [P]ick' })
      vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { desc = '[B]uffer [C]lose Pick' })
      vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
      vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Next buffer' })
    end,
  },

  -- Terminal integration
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup{
        size = 20,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      }

      -- Terminal keymaps
      vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { desc = '[T]oggle [F]loating terminal' })
      vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', { desc = '[T]oggle [H]orizontal terminal' })
      vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', { desc = '[T]oggle [V]ertical terminal' })
    end,
  },

  -- Dashboard (start screen)
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'doom',
        config = {
          header = {
            '',
            '',
            '',
            ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
            ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
            ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
            ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
            ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
            ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
            '',
            '',
            '',
          },
          center = {
            {
              icon = ' ',
              desc = 'Find File           ',
              key = 'f',
              keymap = 'SPC f f',
              action = 'lua require("telescope.builtin").find_files()',
            },
            {
              icon = ' ',
              desc = 'New File            ',
              key = 'n',
              keymap = 'SPC n',
              action = 'enew',
            },
            {
              icon = ' ',
              desc = 'Recent Files        ',
              key = 'r',
              keymap = 'SPC s .',
              action = 'lua require("telescope.builtin").oldfiles()',
            },
            {
              icon = ' ',
              desc = 'Find Text           ',
              key = 'g',
              keymap = 'SPC s g',
              action = 'lua require("telescope.builtin").live_grep()',
            },
            {
              icon = ' ',
              desc = 'Config              ',
              key = 'c',
              keymap = 'SPC s n',
              action = 'lua require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }',
            },
            {
              icon = ' ',
              desc = 'Quit                ',
              key = 'q',
              keymap = 'SPC q',
              action = 'quit',
            },
          },
          footer = {
            '',
            'Happy Coding! 🚀',
          },
        },
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}
