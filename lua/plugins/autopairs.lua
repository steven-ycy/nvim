return {
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true, -- 若有安裝 nvim-treesitter 建議開啟
			})
			-- use opts = {} for passing setup options
			-- this is equivalent to setup({}) function
			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
		end,
	}







}
