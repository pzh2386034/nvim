require("core.option")
require("core.keymaps")
require("plugins.plugins-setup")
require("plugins.nvim-treesitter")
require("plugins.nvim-tree")

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
-- 异步生成 tags (需要 plenary.nvim)
local async = require('plenary.job')

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*',
  callback = function()
    async:new({
      command = 'ctags',
      args = {
        '-R', '-f', '.git/tags',
        '--exclude=node_modules',
        '--exclude=.git',
        '--exclude=dist',
        '.'
      },
      cwd = vim.fn.getcwd(),
      on_exit = function(_, return_val)
        if return_val == 0 then
          print('Tags updated successfully')
        end
      end
    }):start()
  end
})
