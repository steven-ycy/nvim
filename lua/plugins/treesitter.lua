return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function()
		local ts = require("nvim-treesitter")

		-- 1. 指定常用語言，啟動時確保安裝
		local languages = {
			"c",
			"cpp",
			"lua",
			"python",
			"javascript",
			"typescript",
			"java",
			"bash",
			"regex"
		}
		ts.install(languages)

		-- 2. 官方標準寫法：當開啟對應語言檔案時，自動啟用高亮、摺疊與縮排
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterConfig", { clear = true }),
			pattern = languages,
			callback = function()
				-- 啟動 Neovim 原生 Treesitter 語法高亮
				vim.treesitter.start()

				-- 啟用 Treesitter 智慧摺疊
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo.foldmethod = "expr"
				vim.wo.foldenable = false -- 預設不自動摺疊所有程式碼，避免打開檔案時被收合

				-- 啟用 Treesitter 縮排
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
