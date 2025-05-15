require("core.option")
require("core.keymaps")
require("plugins.plugins-setup")
require("plugins.nvim-treesitter")
require("plugins.neotree")

require("plugins/mason-lspconfig")
require("plugins.cmp")
require("plugins.gitsigns")
require('Comment').setup({
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
})

require("plugins.nvim-autopairs")
-- require("plugins.bufferline")
require("plugins.telescope")

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
  end,
})
-- You probably also want to set a keymap to toggle aerial
-- vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
require("plugins.neogit")
require("plugins.luaSnip")
require("plugins.avante")

require("fzf-lua").setup({
  -- MISC GLOBAL SETUP OPTIONS, SEE BELOW
  -- fzf_bin = ...,
  -- each of these options can also be passed as function that return options table
  -- e.g. winopts = function() return { ... } end
  -- files = { ... },
  -- 全局默认全屏
  winopts = {
    fullscreen = true,        -- 强制全屏模式
    preview = {
      -- layout = "vertical",    -- 垂直布局预览
      scrollbar = "border",   -- 带边框的滚动条
    },
  }
})
-- 常用操作映射
vim.keymap.set('n', 'ff', "<cmd>FzfLua files<CR>", { desc = "Find Files" })
vim.keymap.set('n', 'fg', "<cmd>FzfLua live_grep<CR>", { desc = "Live Grep" })
vim.keymap.set('n', 'fc', "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "live Grep Buffer " })
vim.keymap.set('n', 'fa', "<cmd>FzfLua grep_cword<CR>", { desc = "Live Grep current word" })

vim.keymap.set('n', 'fb', "<cmd>FzfLua buffers<CR>", { desc = "Find Buffers" })
vim.keymap.set('n', ',f', "<cmd>FzfLua btags<CR>", { desc = "Find Buffer tags" })
vim.keymap.set('n', 'fs', "<cmd>FzfLua git_status<CR>", { desc = "Find Buffer tags" })
vim.keymap.set('n', 'fh', "<cmd>FzfLua helptags<CR>", { desc = "Find Buffer tags" })
vim.keymap.set('n', 'f/', "<cmd>FzfLua command_history<CR>", { desc = "List history command" })
vim.keymap.set('n', 'fk', "<cmd>FzfLua keymaps<CR>", { desc = "List nvim all keymaps" })
vim.keymap.set('n', 'fz', "<cmd>FzfLua zoxide<CR>", { desc = "Find Buffer tags" })
---- 使用如何命令可以查找快捷键定义
-- :verbose nmap co
--
vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
vim.keymap.set('n', '<leader>da', function() require("duck").cook_all() end, {})
