-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    side = 'left',
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  log = {
      enable = true,
      truncate = true,
      types = {
          diagnostics = true,
      },
  },
})

