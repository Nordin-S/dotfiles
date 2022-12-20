return function(use)
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end
  })
  use({
    'ThePrimeagen/harpoon',
    config = function()
      require("harpoon").setup({
        -- menu = {
        --   width = vim.api.nvim_win_get_width(0) - 4,
        -- }
      })
    end
  })
  use({
    'mbbill/undotree'
    -- config = function()
    -- end
  })
  use({
    'tpopd/vim-fugitive'
    -- config = function()
    -- end
  })
  use({
    'akinsho/toggleterm.nvim',
    -- config = function()
    -- end
  })
  use({
    'christoomey/vim-tmux-navigator'
    -- config = function()
    -- end
  })
  use({
    'folke/zen-mode.nvim',
    -- config = function()
    -- end
  })
  use({
    'github/copilot.vim',
    -- config = function()
    -- end
  })
  use({
    'folke/tokyonight.nvim',
    as = 'tokyonight',
    config = function()
      -- vim.cmd[[colorscheme tokyonight]]
      -- vim.cmd('colorscheme tokyonight-storm')
      -- vim.cmd('colorscheme tokyonight-moon')
      -- vim.cmd('colorscheme tokyonight-dalighty')
    end
  })
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        --- @usage 'main' | 'moon'
        dark_variant = 'main',
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = false,
        disable_float_background = false,
        disable_italics = false,

        --- @usage string hex value or named color from rosepinetheme.com/palette
        groups = {
          background = 'base',
          panel = 'surface',
          border = 'highlight_med',
          comment = 'muted',
          link = 'iris',
          punctuation = 'subtle',

          error = 'love',
          hint = 'iris',
          info = 'foam',
          warn = 'gold',

          headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
          }
          -- or set all headings at once headings = 'subtle'
        },

        -- Change specific vim highlight groups
        highlight_groups = {
          -- ColorColumn = { bg = 'rose' }
        }
      })

      -- set colorscheme after options
      vim.cmd('colorscheme rose-pine')
    end
  })
end
