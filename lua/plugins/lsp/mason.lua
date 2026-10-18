return {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		-- 確保這幾個 LSP 自動安裝
		ensure_installed = {
			"clangd", -- C/C++
			"lua_ls", -- Lua
		},
	},
	dependencies = {
		"neovim/nvim-lspconfig",
		{
			"williamboman/mason.nvim",

			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
	},
}
