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
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
}
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",          -- 后台索引加速
    "--clang-tidy",                -- 启用 clang-tidy
    "--header-insertion=never",    -- 禁止自动插入头文件
    "--all-scopes-completion",     -- 全作用域补全
    "--cross-file-rename",         -- 跨文件重命名
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
})
-- 自动补全配置
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- LSP
    { name = 'luasnip' },  -- 代码片段
    { name = 'buffer' },   -- 当前缓冲区
    { name = 'path' },     -- 文件路径
  })
})
vim.lsp.enable('pyright')

