return {
	{
		"ojroques/vim-oscyank",
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
	{
		{
			"smjonas/inc-rename.nvim",
			config = function()
				require("inc_rename").setup()
				vim.keymap.set("n", "<leader>rn", function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end, { expr = true, desc = "即時重命名變數" })
			end,
		}
	}
}
