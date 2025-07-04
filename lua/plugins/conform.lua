require("conform").setup({
  opts = {
    notify_on_error = false,
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
  --   -- 添加 clang_format 配置
  formatters = {
    clang_format = {
      command = "clang-format",
      args = {
        "-assume-filename=$FILENAME", -- 确保使用正确的文件类型
        "-style=file",                -- 使用项目中的 .clang-format 文件
        "--fallback-style=Microsoft", -- 默认样式
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

vim.keymap.set({ 'n', 'v' }, 'cf', function()
  local mode = vim.fn.mode()
  local ft = vim.bo.filetype
  local range = nil

  -- 获取选中范围（可视化模式）
  if mode:match("[vV]") then
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    if start_pos and end_pos then
      range = {
        start = { start_pos[2], start_pos[3] - 1 },
        ['end'] = { end_pos[2], end_pos[3] }
      }
    end
    vim.cmd('normal! ') -- 退出可视模式
  end

  -- 尝试区域格式化
  local function try_range_formatting()
    local success, result = pcall(function()
      -- 优先尝试 LSP 范围格式化
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      for _, client in ipairs(clients) do
        if client.supports_method("textDocument/rangeFormatting") then
          vim.lsp.buf.format({
            async = true,
            range = range,
            filter = function(c) return c.id == client.id end
          })
          return true
        end
      end

      -- 尝试 conform 范围格式化
      if package.loaded['conform'] then
        require('conform').format({
          async = true,
          lsp_fallback = true,
          timeout_ms = 2000,
          range = range
        })
        return true
      end

      return false
    end)

    return success and result
  end

  -- C/C++ 特殊处理
  if ft == "c" or ft == "cpp" then
    if vim.fn.executable("clang-format") == 1 then
      vim.cmd("silent! write")
      local filepath = vim.fn.expand("%:p")
      local command = "clang-format --fallback-style=Microsoft -i " .. vim.fn.shellescape(filepath)

      if range then
        command = string.format("clang-format --fallback-style=Microsoft -lines=%d:%d -i %s",
          range.start[1], range['end'][1], vim.fn.shellescape(filepath))
      end

      vim.fn.jobstart(command, {
        on_exit = function(_, code)
          if code == 0 then
            vim.cmd("checktime") -- 检查文件修改
            vim.notify("Clang-format successful", vim.log.levels.INFO)
          else
            vim.notify("Clang-format failed: " .. code, vim.log.levels.ERROR)
          end
        end
      })
      return
    end
  end

  -- 通用格式化
  if not try_range_formatting() then
    if range then
      vim.notify("Range formatting not supported for this filetype", vim.log.levels.WARN)
    end

    -- 回退到整个文件格式化
    require('conform').format({
      async = true,
      lsp_fallback = true,
      timeout_ms = 2000
    })
  end
end, {
  desc = "Smart format - whole file or selection"
})
