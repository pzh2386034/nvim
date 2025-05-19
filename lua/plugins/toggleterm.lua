-- init.lua
require("toggleterm").setup({
  size = 15,                -- 默认终端高度（横向）或宽度（纵向）
  direction = "horizontal", -- 方向：horizontal | vertical | float | tab
  close_on_exit = true,     -- 终端退出时自动关闭窗口
  auto_scroll = true,       -- 自动滚动到底部
  persist_mode = false,     -- 记忆终端状态
  shell = vim.o.shell,      -- 使用系统默认 shell
})

-- 打开/关闭默认终端
vim.keymap.set('n', '<C-\\>', '<cmd>ToggleTerm<CR>', { desc = "Toggle terminal" })

-- 发送当前行到终端
vim.key_map.set('n', '<leader>tt', function()
  local line = vim.api.nvim_get_current_line()
  require('toggleterm').exec(line)
end, { desc = "Send line to terminal" })

vim.keymap.set('v', '<leader>ts', function()
  local content = require('toggleterm').selection.get()
  require('toggleterm').exec(content)
end, { desc = "Send selection to terminal" })

require('lualine').setup({
  sections = {
    lualine_x = {
      {
        require("toggleterm").statusline,
        cond = require("toggleterm").statusline_cond
      }
    }
  }
})
