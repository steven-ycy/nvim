vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<bar>echo ''<CR>", { desc = "清除搜尋高亮與狀態列訊息" })
local modes = { "n", "i", "v", "x", "s", "c", "t" }
vim.keymap.set(modes, "<CapsLock>", "<Esc>", { desc = "Map CapsLock to Esc" })
vim.keymap.set("n", "<leader>fm", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer (Auto indent & code style)" })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "<leader>fw", function()
	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(w).relative ~= "" and w ~= vim.api.nvim_get_current_win() then
			vim.api.nvim_set_current_win(w)
			return
		end
	end
end, { desc = "Jump to next popup" })
