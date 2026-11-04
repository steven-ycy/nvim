return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"catppuccin/nvim",

	},
	opts = function()
		return {
			options    = {
				theme = 'everforest',
			},
			extensions = { 'toggleterm', 'quickfix' },
			sections   = {


				lualine_y = {
					{
						'location',
					},
					{
						'progress',
					},
				},
				lualine_z = {

					{
						'datetime',
						-- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
						style = "%H:%M %a %m/%d",
						icon = { "\u{f144c}", },

					}

				},
			}
		}
	end
}
