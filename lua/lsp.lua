--print("so i open this file")
--  local my_target_test = 999
-- print(my_target_test)
local severity = vim.diagnostic.severity
--	print("CONFIG_RUNNING")
vim.diagnostic.config({

	signs = {
		text = {
			[severity.ERROR] = "\u{f057}",
			[severity.WARN]  = "\u{f071}",
			[severity.HINT]  = "\u{f0820}",
			[severity.INFO]  = "\u{f05a}",
		},
	},
	-- virtual_text = true,  在行尾顯示錯誤文字訊息
	underline = true,
	update_in_insert = false,
	severity_sort = true,

	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		format = function(diagnostic)
			local icons = {
				[vim.diagnostic.severity.ERROR] = "\u{f057}",
				[vim.diagnostic.severity.WARN] = "\u{f071}",
				[vim.diagnostic.severity.INFO] = "\u{f0820}",
				[vim.diagnostic.severity.HINT] = "\u{f05a}",
			}
			local icon = icons[diagnostic.severity] or "● "
			return string.format("%s %s", icon, diagnostic.message)
		end,

	},
})

-- 診斷跳轉快捷鍵（全域通用，不依賴個別 LSP 連線）
local map = vim.keymap.set
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })

map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic error float" })
map("n", "<leader>D", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

-- =========================================================================
-- 2. LSP 快捷鍵設定 (在伺服器成功連線到當前 Buffer 時觸發)
-- =========================================================================
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- 設定僅在當前緩衝區 (Buffer) 生效的快捷鍵
		local opts = { buffer = ev.buf, silent = true }
		-- 定義與宣告跳轉
		opts.desc = "Go to definition"
		map("n", "gD", vim.lsp.buf.definition, opts)

		opts.desc = "Go to declaration"
		map("n", "gd", vim.lsp.buf.declaration, opts)

		opts.desc = "Go to implementation"
		map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)

		opts.desc = "Go to type definition"
		map("n", "<leader>t", vim.lsp.buf.type_definition, opts)

		-- 資訊提示與說明
		opts.desc = "Hover documentation"
		map("n", "K", vim.lsp.buf.hover, opts)


		opts.desc = "Signature documentation"
		map("n", "<leader>k", vim.lsp.buf.signature_help, opts)

		-- -- 程式碼操作與重新命名
		-- opts.desc = "Smart rename"
		-- map("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "Code action"
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		-- 引用查詢 (若有安裝 Telescope，也可改為 "<cmd>Telescope lsp_references<cr>")
		opts.desc = "Show references"
		map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)

		-- 程式碼格式化
	end,
})
