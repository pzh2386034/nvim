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

--------------------- telescope begin ------------------------------
require('telescope').setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    },
    defaults = {
      mappings = {
        i = {
          ["<C-k>"] = require('telescope.actions').move_selection_previous, -- 新映射
          ["<C-p>"] = false, -- 禁用旧映射
          ["<C-n>"] = false, -- 禁用旧映射,
          ["<C-j>"] = require('telescope.actions').move_selection_next, -- 保持默认
          ["<Esc>"] = require('telescope.actions').close, -- 保持默认退出
          -- 其他自定义映射...
          ["<C-y>"] = require('telescope.actions').send_selected_to_qflist, --  TODO: 选中后自动打开quickfix(actions.open_qflist())
          ["<M-q>"] = false, -- 禁用原快捷键
        },
        n = {
        },
      },
    }
}
-- require('telescope').load_extension('fzy_native')
local builtin = require('telescope.builtin')
-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fa', builtin.live_grep, {})  -- 环境里要安装ripgrep
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', 'f/', builtin.command_history, {})

vim.keymap.set('n', '<leader>ff', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fi', builtin.lsp_incoming_calls, {})
vim.keymap.set('n', '<leader>fo', builtin.lsp_outgoing_calls, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fj', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>ft', builtin.tags, {})

vim.keymap.set('n', '<leader>gs', builtin.git_status, {})

--------------------- telescope end------------------------------
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
