local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>vm', builtin.man_pages, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
        find_command = {
            'fd',
            '--type', 'file',
            '--exclude', '*_templ.go',
        }
    })
end, {})

vim.keymap.set('n', '<leader>ph', function()
    builtin.find_files({
        find_command = {
            'fd',
            '--type', 'file',
            '--hidden',
            '--exclude', 'node_modules',
            '--exclude', 'site-packages',
            '--exclude', '.git',
            '--exclude', '*_templ.go',
            '--exclude', '.DS_Store'
        },
        no_ignore = true,
        no_ignore_parent = true
    })
end, {})

require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    },
}
