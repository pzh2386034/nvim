require("telescope-orgmode").setup({
    config = function()
      require("telescope").load_extension("orgmode")

      vim.keymap.set("n", "<leader>or", require("telescope").extensions.orgmode.refile_heading)
      vim.keymap.set("n", "<leader>oh", require("telescope").extensions.orgmode.search_headings)
      vim.keymap.set("n", "<leader>oi", require("telescope").extensions.orgmode.insert_link)
    end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'org',
  group = vim.api.nvim_create_augroup('orgmode_telescope_nvim', { clear = true }),
  callback = function()
    vim.keymap.set('n', '<leader>or', require('telescope').extensions.orgmode.refile_heading)
  end,
})
