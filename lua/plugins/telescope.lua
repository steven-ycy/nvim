return
{
	'nvim-telescope/telescope.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		"rcarriga/nvim-notify",
		"folke/noice.nvim",
		"folke/noice.nvim",
		"catppuccin/nvim",
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	config = function()
		local telescope = require("telescope")
		local colors = require("catppuccin.palettes").get_palette("mocha")


		telescope.setup {
			defaults = {
				prompt_prefix = "🍋 ",
				layout_config = {
					horizontal = {
						preview_width = 0.5,
					}


				}
			}

		}

		local function set_telescope_windows_transparent()
			local colors = require("catppuccin.palettes").get_palette("mocha")

			local content_groups = {
				"TelescopeNormal",
				"TelescopePromptNormal",
				"TelescopePromptPrefix",
				"TelescopeResultsNormal",
				"TelescopePreviewNormal",
			}

			for _, name in ipairs(content_groups) do
				local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
				hl.bg = "none"
				hl.ctermbg = "none"
				vim.api.nvim_set_hl(0, name, hl)
			end

			local border_groups = {
				"TelescopePromptBorder",
				"TelescopeResultsBorder",
				"TelescopePreviewBorder",
			}

			for _, name in ipairs(border_groups) do
				vim.api.nvim_set_hl(0, name, {
					fg = colors.yellow, bg = "none", ctermbg = "none",
				})
			end
			vim.api.nvim_set_hl(0, "TelescopePreviewTitle"
			, { bg = "none", fg = colors.maroon })
			vim.api.nvim_set_hl(0, "TelescopeResultsTitle"
			, { bg = "none", fg = colors.maroon })
			vim.api.nvim_set_hl(0, "TelescopePromptTitle"
			, { bg = "none", fg = colors.maroon })
			vim.api.nvim_set_hl(0, "TelescopeSelection", { link = "CursorLine" })
			vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { link = "CursorLine" })
		end

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_telescope_windows_transparent,
		})

		-- 立即套用
		set_telescope_windows_transparent()



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
