require'lualine'.setup {
    options = {
        theme = 'everforest'
    }
}

if vim.fn.has('termguicolors') then
    vim.o.termguicolors = true
end

vim.o.background = 'light'

vim.g.everforest_background = 'hard'
vim.g.everforest_better_performance = 1
vim.g.everforest_transparent_background = 0

vim.cmd 'colorscheme everforest'
