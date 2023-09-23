local options = {
	autoindent = true,
	smartindent = true,
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	showtabline = 1,

	number = true,
	relativenumber = true,
	incsearch = true,
	numberwidth = 4,
	hlsearch = false,
	ignorecase = true,
	smartcase = true,

	splitbelow = true,
	splitright = true,

	termguicolors = true,
	hidden = true,
	signcolumn = "yes",
	showmode = false,
	errorbells = false,
	wrap = false,
	cursorline = false,
	fileencoding = "utf-8",

	backup = false,
	writebackup = false,
	swapfile = false,
	undodir = os.getenv("HOME") .. "/.vim/undodir",
	undofile = true,
	
	colorcolumn = "80",
	updatetime = 200,
	scrolloff = 15,
	mouse = "a",
	guicursor = "a:block",

	title = true,
	titlestring = "Neovim - %t",
	guifont = "MesloLGS NF:h18"
}

vim.opt.shortmess:append("IsF")

for option, value in pairs(options) do
	vim.opt[option] = value
end
