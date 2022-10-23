local opts = {
  noremap = true,
  silent = true,
}

vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<CR>', opts)
