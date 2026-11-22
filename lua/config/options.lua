vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.g.lazygit_floating_window_winblend = 15 -- 數值越大越透明（0-100）
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- 強制在 SSH 無頭環境下使用 OSC 52 透過 WezTerm 傳遞剪貼簿
if vim.env.SSH_TTY then
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = require("vim.ui.clipboard.osc52").paste("+"),
			["*"] = require("vim.ui.clipboard.osc52").paste("*"),
		},
	}
end
