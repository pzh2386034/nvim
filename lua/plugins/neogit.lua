-- init.lua
local neogit = require('neogit')

neogit.setup({
  integrations = {
    diffview = true,                    -- 启用 diffview 集成
    telescope = true                    -- 启用 telescope 集成
  },
  disable_signs = false,                -- 是否显示 git 状态符号
  disable_hint = false,                 -- 是否显示底部帮助提示
  disable_context_highlighting = false, -- 禁用上下文高亮（性能优化）
  commit_popup = {
    kind = "split",                     -- 提交信息编辑窗口类型 (split, vsplit, tab)
  },
  mappings = {
    status = {
      ["q"] = "Close", -- 自定义关闭快捷键
      ["s"] = "Stage", -- 快速暂存文件
    }
  }
})
-- vim.keymap.set('n', 'gt', ":Neogit<CR>")
vim.keymap.set('n', 'gt', function()
  local file_dir = vim.fn.expand('%:p:h')    -- Get the directory of the current file
  require('neogit').open({ cwd = file_dir }) -- Open Neogit in the file's directory
end, { noremap = true, silent = true, desc = "Open current file's directory in Neogit" })
-- vim.keymap.set('n', 'cc', function()
--   require('neogit').open({ kind = "split" })
--   require('neogit').dispatch("commit")
-- end, { desc = "快速提交" })
