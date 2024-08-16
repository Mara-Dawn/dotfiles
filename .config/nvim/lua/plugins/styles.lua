return {
  {
    'catppuccin/nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    name = 'catppuccin',
    init = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      scope = {
        show_start = false,
        show_end = false,
        highlight = 'FloatTitle',
      },
    },
  },
  {
    'f-person/git-blame.nvim',
    -- load the plugin at startup
    event = 'VeryLazy',
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = ' <summary> • <date> • <author> • <<sha>>', -- template for the blame message, check the Message template section for more options
      date_format = '%d-%m-%Y %H:%M:%S', -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
      display_virtual_text = 0,
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      local git_blame = require 'gitblame'
      return {
        options = {
          theme = function()
            local colors = {
              gray = '#313244',
              lightgray = '#585b70',
              lightergray = '#9399b2',
              pink = '#f5c2e7',
              purple = '#cba6f7',
              red = '#f38ba8',
              yellow = '#f9e2af',
              green = '#a6e3a1',
              white = '#f5c2e7',
              black = '#11111b',
            }

            return {
              normal = {
                a = { bg = colors.purple, fg = colors.black, gui = 'bold' },
                b = { bg = colors.lightgray, fg = colors.white },
                c = { bg = colors.gray, fg = colors.lightergray },
              },
              insert = {
                a = { bg = colors.green, fg = colors.black, gui = 'bold' },
                b = { bg = colors.lightgray, fg = colors.white },
                c = { bg = colors.gray, fg = colors.lightergray },
              },
              visual = {
                a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
                b = { bg = colors.lightgray, fg = colors.white },
                c = { bg = colors.gray, fg = colors.lightergray },
              },
              replace = {
                a = { bg = colors.red, fg = colors.black, gui = 'bold' },
                b = { bg = colors.lightgray, fg = colors.white },
                c = { bg = colors.gray, fg = colors.lightergray },
              },
              command = {
                a = { bg = colors.pink, fg = colors.black, gui = 'bold' },
                b = { bg = colors.lightgray, fg = colors.white },
                c = { bg = colors.gray, fg = colors.lightergray },
              },
              inactive = {
                a = { bg = colors.gray, fg = colors.white, gui = 'bold' },
                b = { bg = colors.lightgray, fg = colors.white },
                c = { bg = colors.gray, fg = colors.lightergray },
              },
            }
          end,
          component_separators = '',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { { 'mode', separator = { right = '' }, left_padding = 2 } },
          lualine_b = { 'filename', 'branch' },
          lualine_c = {
            function()
              local reg = vim.fn.reg_recording()
              if reg == '' then
                return ''
              end -- not recording
              return '> Recording to ' .. reg .. ' < '
            end,
            {
              git_blame.get_current_blame_text,
              cond = git_blame.is_blame_text_available,
            },
          },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { left = '' }, right_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      routes = {
        {
          filter = {
            event = 'notify',
            find = 'No information available',
          },
          opts = { skip = true },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      { 'rcarriga/nvim-notify' },
    },
  },
}
