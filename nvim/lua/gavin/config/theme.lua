require'lualine'.setup {
    options = {
        theme = 'everforest'
    }
}

if vim.fn.has('termguicolors') then
    vim.o.termguicolors = true
end

vim.o.background = 'dark'

vim.g.everforest_background = 'soft'
vim.g.everforest_better_performance = 1
vim.g.everforest_transparent_background = 1
vim.g.everforest_enable_italic = 0
vim.g.everforest_diagnostic_virtual_text = 'grey'

vim.cmd 'colorscheme everforest'
