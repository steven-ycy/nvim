return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		image = {
			enabled = true,
		},
		notifier = {
			enabled = false,
			timeout = 3000,
		},
		dashboard = { enable = true },
		picker = { enabled = true },
	},
	keys = {
		{
			"<leader>db",
			function()
				Snacks.dashboard()
			end,
			desc = "Open Dashboard",
		},
		-- {
		-- 	"<leader>un",
		-- 	function() Snacks.notifier.show_history() end,
		-- 	desc = "Notification History",
		-- },
		-- {
		-- 	"<leader>unx",
		-- 	function() Snacks.notifier.hide() end,
		-- 	desc = "Dismiss All Notifications",
		-- },
		-- {
		-- 	"<leader>su",
		-- 	function()
		-- 		Snacks.picker.undo()
		-- 	
		-- 	end,
		-- 	desc = "Search Undo Tree",
		-- },
	},
}
