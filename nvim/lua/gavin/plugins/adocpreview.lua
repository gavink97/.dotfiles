config = function()
  require('asciidoc-preview').setup({
    server = {
      converter = 'js',
      port = 11235

    },
    preview = {
      position = 'current',
    },
  })
end

vim.keymap.set('n', '<Leader>cp', ':AsciiDocPreview<CR>', { desc = 'Preview AsciiDoc document' })
