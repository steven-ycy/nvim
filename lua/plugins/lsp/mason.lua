return {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"clangd", -- C / C++ (eBPF, XDP, NS-3, Socket)
			"lua_ls", -- Lua (Neovim 配置)
			"basedpyright", -- Python (Mininet, Ryu SDN 控制器, Scapy)
			"ruff", -- Python 靜態檢查與快速修復
			"bashls", -- Bash (iproute2 / network namespace 自動化實驗腳本)
			"yamlls", -- YAML (Containerlab / Docker Compose 網路拓樸)
			"jsonls", -- JSON (REST API / OpenFlow / 設定檔)
		},
	},
	dependencies = {
		-- like a lib? needed downloading, and it is enough
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
