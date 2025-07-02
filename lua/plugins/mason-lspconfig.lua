local cmp = require("cmp")
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "ts_ls",
    "clangd"
  },
  automatic_enable = false,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
}
vim.lsp.enable('pyright')

require "lsp_signature".setup({
  bind = true,
  handler_opts = {
    border = "rounded"
  },
  hint_enable = false,       -- 禁用内联提示（可能干扰补全）
  hint_prefix = "🐼 ",
  floating_window_off_x = 5, -- 调整浮动窗口位置
  toggle_key = '<M-x>',      -- 切换签名帮助的快捷键
})

require("lsp_signature").setup(signature_config)

require("lspconfig").gopls.setup({ capabilities = capabilities })
require("lspconfig").clangd.setup({ capabilities = capabilities })
