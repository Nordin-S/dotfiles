vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')

local toggleGloss = false;
vim.keymap.set("n", "<leader>zt", function()
    local themeName = vim.g.colors_name

    toggleGloss = not toggleGloss
    if toggleGloss then
        -- Set the background to transparent
        vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi CursorLine guibg=NONE ctermbg=NONE")
        vim.cmd("hi ColorColumn guibg=NONE ctermbg=NONE")
        vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
    else
        -- Restore the original background color
        vim.cmd("colo " .. themeName)
    end
end)
