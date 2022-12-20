function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.cmd("hi SignColumn ctermbg=none guibg=none")
	vim.cmd("hi ColorColumn ctermbg=none guibg=#1e222a")

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
ColorMyPencils()
