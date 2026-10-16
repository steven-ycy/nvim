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
