return {
	"keaising/im-select.nvim",
	config = function()
		require("im_select").setup({
			default_command = "/mnt/d/FilesInD/tools/im-select.exe",
			default_im_select = "1033",
			set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

			set_previous_events = { "InsertEnter", },

			async_switch_im = true,
		})
	end,
}
--for wsl version or window
