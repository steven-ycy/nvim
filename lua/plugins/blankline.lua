return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowOrange",
				"RainbowYellow",
				"RainbowGreen",
				"RainbowCyan",
				"RainbowBlue",
				"RainbowViolet",
			}

			local highlight1 = {
				"RainbowRed1",
				"RainbowOrange1",
				"RainbowYellow1",
				"RainbowGreen1",
				"RainbowCyan1",
				"RainbowBlue1",
				"RainbowViolet1",
			}



			local hooks = require "ibl.hooks"
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed1", { fg = "#A04047" })
				vim.api.nvim_set_hl(0, "RainbowYellow1", { fg = "#A38545" })
				vim.api.nvim_set_hl(0, "RainbowBlue1", { fg = "#3D7099" })
				vim.api.nvim_set_hl(0, "RainbowViolet1", { fg = "#854996" })
				vim.api.nvim_set_hl(0, "RainbowCyan1", { fg = "#367B84" })
				vim.api.nvim_set_hl(0, "RainbowGreen1", { fg = "#63874B" })
				vim.api.nvim_set_hl(0, "RainbowOrange1", { fg = "#9E6838" })
			end)


			require("ibl").setup { scope = { highlight = highlight, char = "▎", show_end = false, show_start = false }, indent = { highlight = highlight1, char = "▏" } }
		end,
	}













}
