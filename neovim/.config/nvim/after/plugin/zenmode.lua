vim.keymap.set("n", "<leader>zm", function()
	require("zen-mode").setup({
		window = {
			backdrop = 1.0,
			width = 90,
			options = {},
		},
	})
	require("zen-mode").toggle()
	vim.wo.wrap = false
	vim.wo.number = true
	vim.wo.rnu = true
end)

vim.keymap.set("n", "<leader>zM", function()
	require("zen-mode").setup({
		window = {
			backdrop = 0.0,
			width = 90,
			options = {},
		},
	})
	require("zen-mode").toggle()
	vim.wo.wrap = false
	vim.wo.number = true
	vim.wo.rnu = true
end)
