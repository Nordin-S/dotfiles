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
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4,
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
