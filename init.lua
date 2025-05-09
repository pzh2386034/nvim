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

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
  end,
})
-- You probably also want to set a keymap to toggle aerial
-- vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")


---- 使用如何命令可以查找快捷键定义
-- :verbose nmap co
