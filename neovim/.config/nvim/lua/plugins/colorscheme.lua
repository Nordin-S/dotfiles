return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha

      -- Some schemas/LSPs expect this to be a TABLE with a float key
      -- Catppuccin itself only needs boolean, but this keeps diagnostics happy.
      transparent_background = { enabled = true, float = true },

      background = {
        light = "latte",
        dark = "mocha",
      },

      show_end_of_buffer = false,
      term_colors = true,

      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },

      no_italic = false,
      no_bold = false,
      no_underline = false,

      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        functions = { "bold" },
        keywords = { "italic" },
      },

      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = { enabled = true },
        notify = false,
        mini = false,
        -- add other integrations you use here
      },

      -- Make sure *everything* respects transparency, and use colors so LSP is happy.
      custom_highlights = function(colors)
        return {
          Normal = { bg = "NONE" },
          NormalNC = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          LineNr = { bg = "NONE" },

          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE", fg = colors.surface2 },
          FloatTitle = { bg = "NONE", fg = colors.text },

          Pmenu = { bg = "NONE" },
          PmenuSel = { bg = colors.surface1, fg = colors.text },
          PmenuSbar = { bg = "NONE" },
          PmenuThumb = { bg = colors.surface1 },

          -- Telescope + borders
          TelescopeNormal = { bg = "NONE" },
          TelescopeBorder = { bg = "NONE", fg = colors.surface2 },
          TelescopePromptNormal = { bg = "NONE" },
          TelescopePromptBorder = { bg = "NONE", fg = colors.surface2 },

          -- WhichKey / Lazy / Mason etc. floats
          WhichKeyFloat = { bg = "NONE" },
          LazyNormal = { bg = "NONE" },
          MasonNormal = { bg = "NONE" },

          ColorColumn = { bg = colors.surface0 },
        }
      end,
    },
  },
}
-- return {
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "catppuccin",
--     },
--   },
--   {
--     "catppuccin",
--     opts = {
--       transparent_background = true,
--     },
--   },
--   -- border highlight when background is transparent
--   {
--     "hrsh7th/nvim-cmp",
--     opts = function(_, opts)
--       opts.window = {
--         completion = {
--           border = "rounded",
--           winhighlight = "Normal:MyHighlight",
--           winblend = 0,
--         },
--         documentation = {
--           border = "rounded",
--           winhighlight = "Normal:MyHighlight",
--           winblend = 0,
--         },
--       }
--     end,
--   },
--   {
--     "williamboman/mason.nvim",
--     opts = {
--       ui = {
--         border = "rounded",
--       },
--     },
--   },
--   {
--     "folke/noice.nvim",
--     opts = {
--       presets = {
--         lsp_doc_border = true,
--       },
--     },
--   },
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       diagnostics = {
--         float = {
--           border = "rounded",
--         },
--       },
--     },
--   },
--   {
--     "nvim-neo-tree/neo-tree.nvim",
--     opts = {
--       ui = {
--         border = "rounded",
--         background = "transparent",
--       },
--     },
--   },
-- }
-- return {
--   {
--     "tokyonight.nvim",
--     opts = {
--       transparent = true,
--       terminal_colors = true,
--       styles = {
--         sidebars = "transparent",
--         floats = "transparent",
--         comments = { italic = true },
--         keywords = { italic = true },
--       },
--     },
--   },
--   -- border highlight when background is transparent
--   {
--     "hrsh7th/nvim-cmp",
--     opts = function(_, opts)
--       opts.window = {
--         completion = {
--           border = "rounded",
--           winhighlight = "Normal:MyHighlight",
--           winblend = 0,
--         },
--         documentation = {
--           border = "rounded",
--           winhighlight = "Normal:MyHighlight",
--           winblend = 0,
--         },
--       }
--     end,
--   },
--   {
--     "williamboman/mason.nvim",
--     opts = {
--       ui = {
--         border = "rounded",
--       },
--     },
--   },
--   {
--     "folke/noice.nvim",
--     opts = {
--       presets = {
--         lsp_doc_border = true,
--       },
--     },
--   },
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       diagnostics = {
--         float = {
--           border = "rounded",
--         },
--       },
--     },
--   },
-- }
