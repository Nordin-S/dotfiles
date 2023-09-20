local last_colorscheme = ""

local function configureColorscheme()
    local colorscheme_name = vim.g.colors_name 

    if colorscheme_name and colorscheme_name ~= last_colorscheme then
        last_colorscheme = colorscheme_name
        local config = require(colorscheme_name)

        if config.setup then
            config.setup({
                disable_background = true,
            })

            -- Set background color to "none"
            vim.o.background = "none"

            -- Clear background color for specific highlighting groups
            vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
            vim.cmd('highlight SignColumn guibg=NONE ctermbg=NONE')
        end
    end
end

vim.cmd([[
    augroup AutoColorschemeConfig
        autocmd!
        autocmd ColorScheme * lua require'colorscheme_autoconfig'.configureColorscheme()
    augroup END
]])

