vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.opt.clipboard = "unnamedplus"

-- 按 Esc 同時清除搜尋高亮並清空底部訊息
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<bar>echo ''<CR>", { desc = "清除搜尋高亮與狀態列訊息" })
-- Normal, Insert, Visual, Terminal 模式下 CapsLock 行為等同於 Esc
local modes = { "n", "i", "v", "x", "s", "c", "t" }
vim.keymap.set(modes, "<CapsLock>", "<Esc>", { desc = "Map CapsLock to Esc" })
vim.keymap.set("n", "<leader>fm", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer (Auto indent & code style)" })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })
