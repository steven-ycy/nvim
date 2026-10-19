return
{
	'nvim-telescope/telescope.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		"rcarriga/nvim-notify",
		"folke/noice.nvim",
		"folke/noice.nvim",
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({})
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "notify")
		pcall(telescope.load_extension, "noice")
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set("n", "<leader>sm", "<cmd>Noice telescope<cr>", { desc = "Search Messages (Noice)" })
		vim.keymap.set("n", "<leader>fn", function()
			require("telescope").extensions.notify.notify()
		end, { desc = "搜尋通知歷史 (Notify History)" })
	end
}
