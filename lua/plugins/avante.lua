local avante = require('avante')

avante.setup({
  provider = "deepseek",
  vendors = {
    deepseek = {
      __inherited_from = "openai",
      api_key_name = "deep_api_key",
      endpoint = "https://api.deepseek.com",
      model = "deepseek-coder",
    },
  },
  behaviour = {
    auto_set_highlight_group = true,
    auto_apply_diff_after_generation = false,
  },
  mappings = {
    ask = "<leader>aa",
    refresh = "<leader>ar",
  },
  windows = {
    wrap = true,
    width = 40,
  },
})
