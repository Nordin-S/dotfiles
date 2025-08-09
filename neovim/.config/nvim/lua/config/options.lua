-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local options = {
  title = true,
  titlestring = "Neovim - %t",
  guifont = "Fira Code NF:h18",

  number = true,
  relativenumber = true,
  numberwidth = 4,
  signcolumn = "yes",
  showmode = false,
  cursorline = false,
  colorcolumn = "80",
  showtabline = 1,
  termguicolors = true,

  autoindent = true,
  smartindent = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,

  incsearch = true,
  hlsearch = false,
  ignorecase = true,
  smartcase = true,

  splitbelow = true,
  splitright = true,

  fileencoding = "utf-8",
  backup = false,
  writebackup = false,
  swapfile = false,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,

  errorbells = false,
  wrap = false,
  hidden = true,
  updatetime = 50,
  scrolloff = 8,
  mouse = "a",
  --guicursor = "a:block",
  guicursor = "",
  --isfname:append("@-@"),
}
vim.opt.shortmess:append("IsF")

for option, value in pairs(options) do
  vim.opt[option] = value
end

-- Define highlight groups for different modes
vim.api.nvim_set_hl(0, "CursorNormal", { fg = "black", bg = "white" })
vim.api.nvim_set_hl(0, "CursorInsert", { fg = "white", bg = "red" })
vim.api.nvim_set_hl(0, "CursorVisual", { fg = "white", bg = "purple" })

-- Set guicursor for normal, insert, and visual modes
vim.opt.guicursor = {
  "n:block-CursorNormal", -- Normal mode: block cursor with CursorNormal highlight
  "i:ver25-CursorInsert", -- Insert mode: vertical bar cursor (25%) with CursorInsert highlight
  "v:block-CursorVisual", -- Visual mode: block cursor with CursorVisual highlight
}
