vim.api.nvim_create_user_command('Rfinder',
    function()
        local path = vim.api.nvim_buf_get_name(0)
        -- add support for executing open if no file in buffer
        os.execute('open -R ' .. path)
        -- os.execute('xdg-open ' .. vim.fn.fnameescape(vim.fn.expand('%:p:h')))
    end,
    {}
)

vim.keymap.set("n", "<leader>r", function()
    vim.cmd("Rfinder")
end)
