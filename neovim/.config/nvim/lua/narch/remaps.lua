local Remap = require("narch.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap
local tnoremap = Remap.tnoremap

local silent = { silent = true }

-- enter normal mode
inoremap("jj", "<Esc>")

-- move between splits
-- nnoremap("<C-L>", "<C-W>l")
-- nnoremap("<C-H>", "<C-W>h")
-- nnoremap("<C-J>", "<C-W>j")
-- nnoremap("<C-K>", "<C-W>k")

-- resize splits
nnoremap("<A-h>", "2<C-W>>")
nnoremap("<A-l>", "2<C-W><")
nnoremap("<A-j>", "2<C-W>-")
nnoremap("<A-k>", "2<C-W>+")

-- search accurance center
nnoremap("n", "nzz")
nnoremap("N", "Nzz")

-- copy/paste
vnoremap("<leader>y", "\"+y", silent)

-- built in terminal
nnoremap("<leader>t", "<Cmd>sp<CR> <Cmd>term<CR> <Cmd>resize 20N<CR> i", silent)
tnoremap("<C-c><C-c>", "<C-\\><C-n>", silent)
tnoremap("<D-v>", function()
    local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>\"+pi", true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
end, silent)

-- spelling
nnoremap("<C-s>", "<Cmd>set spell!<CR>", silent)

-- Running Code
nnoremap("<leader>cb", "<Cmd>Build<CR>", silent)
nnoremap("<leader>cd", "<Cmd>DebugBuild<CR>", silent)
nnoremap("<leader>cl", "<Cmd>Run<CR>", silent)
nnoremap("<leader>cr", "<Cmd>Ha<CR>", silent)
