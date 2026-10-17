return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		image = {
			enabled = true, -- 開啟圖片渲染功能
		},
		notifier = {
			enabled = true, -- 取代 nvim-notify，美化彈出訊息
			timeout = 3000,
		},
		dashboard = { enable = true },
	},
	keys = {
		-- 綁定快捷鍵（例如 <leader>bd 或 <leader>db）
		{
			"<leader>db",
			function()
				Snacks.dashboard()
			end,
			desc = "開啟 Dashboard",
		},
	},
}
