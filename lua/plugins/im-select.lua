return {
	"keaising/im-select.nvim",
	event = "InsertEnter",
	config = function()
		require("im_select").setup({
			-- 預設切回英文時的代碼
			default_im_select = "xkb:us::eng",

			-- 指定剛剛建立的 IBus 切換腳本絕對路徑
			default_command = vim.fn.expand("~/.local/bin/ibus-switch"),

			-- 定義觸發切回英文的時機
			set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

			-- 再次進入 Insert 時是否還原先前的中文狀態
			set_previous_events = { "InsertEnter" },

			-- IBus 透過 D-Bus 通訊建議設為 true 避免卡頓
			async_switch_im = true,
		})
	end,
}
