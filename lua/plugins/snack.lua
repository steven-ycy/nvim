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
	},
}
