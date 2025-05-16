local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-l>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- 通过telescope浏览snips
vim.keymap.set('n', '<leader>st', "<cmd>Telescope luasnip<CR>", { desc = "List All Snippets" })
-- 快速编辑片段
vim.keymap.set("n", "<leader>se", function()
  require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit Snippets" })


require("luasnip.loaders.from_vscode").lazy_load({
  paths = { "~/snippets" } -- 自定义片段目录（可选）
})

require("luasnip.loaders.from_lua").lazy_load({
  paths = { "~/.config/nvim/lua/snippets" }
})
