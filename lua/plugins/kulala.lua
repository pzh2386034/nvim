require("kulala").setup({
  {
    keys = {
      { "<leader>ks", desc = "Send request" },
      { "<leader>ka", desc = "Send all requests" },
      { "<leader>kb", desc = "Open scratchpad" },
    },
    ft = {"http", "rest"},
    opts = {
      -- your configuration comes here
      global_keymaps = false,
    },
  },
})
