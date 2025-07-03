require("conform").setup({
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { c = true, cpp = true }
    --   if disable_filetypes[vim.bo[bufnr].filetype] then
    --     return nil
    --   else
    --     return {
    --       timeout_ms = 500,
    --       lsp_format = 'fallback',
    --     }
    --   end
    -- end,
  },
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    go = { "goimports", "gofmt" },
    -- You can also customize some of the format options for the filetype
    rust = { "rustfmt", lsp_format = "fallback" },
    -- You can use a function here to determine the formatters dynamically
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    c = { "clang_format" },
    cpp = { "clang_format" },
    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
  -- Set this to change the default values when calling conform.format()
  -- This will also affect the default values for format_on_save/format_after_save
  default_format_opts = {
    lsp_format = "fallback",
  },
  -- If this is set, Conform will run the formatter on save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  -- format_on_save = {
  --   -- I recommend these options. See :help conform.format for details.
  --   lsp_format = "fallback",
  --   timeout_ms = 500,
  -- },
  --   -- 添加 clang_format 配置
  formatters = {
    clang_format = {
      command = "clang-format",
      args = {
        "-assume-filename=$FILENAME", -- 确保使用正确的文件类型
        "-style=file",                -- 使用项目中的 .clang-format 文件
        "--fallback-style=Microsoft",       -- 默认样式
      },
      cwd = require("conform.util").root_file({
        ".clang-format",       -- 项目级配置文件
        ".clang-format-ignore" -- 忽略文件
      }),
    },
  },
})
vim.keymap.set('n', 'cf', function()
  require('conform').format({
    async = true,        -- 异步格式化不阻塞编辑器
    lsp_fallback = true, -- 回退到 LSP 格式化
    timeout_ms = 2000,   -- 超时时间
  })
end, { desc = "Format current buffer" })
