local function enable_transparency()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

return {
	{
		"folke/tokyonight.nvim",
		config = function()
			--   vim.cmd.colorscheme "tokyonight"
			enable_transparency()
		end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				integrations = {
					treesitter = true,
					neotree = true,
					telescope = { enabled = true },
					mason = true,
					which_key = true,
					noice = true,
					notify = true,
					cmp = true,
				},
				custom_highlights = function(colors)
					return {
						Normal       = { bg = "none" },
						CursorLineNr = { fg = colors.peach, bold = true },
						CursorLine   = { bg = "#040935", fg = "#ffffe5" },
						LineNr       = { fg = "#415a77", bg = "none" },
						Visual       = { bg = "#1b2438", fg = "none" },
						SFloatBorder = { fg = colors.lavender, bg = "#1e1e2e", bold = true },
						SNormalFloat = { bg = "#1e1e2e" },
						FloatBorder  = { fg = colors.yellow, bg = "none" },
						NormalFloat  = { bg = "none" },
						FloatTitle   = { bg = "none", fg = colors.maroon, bold = true },


						LazyGitBorder = { fg = colors.yellow, bold = true },
						LazyGitFloat = { bg = "none", fg = colors.rosewater },

						Search = { bg = colors.yellow, fg = colors.base, bold = true },
						IncSearch = { bg = colors.yellow, fg = colors.base, bold = true },

						NeoTreeCursorLine = { link = "CursorLine" },
						NeoTreeDirectoryIcon = { fg = colors.yellow },
						NeoTreeDirectoryName = { fg = colors.text },
						SnacksDashboardHeader = { fg = colors.yellow, bold = true },
						NeoTreeNormal = { bg = "none" },
						NeoTreeNormalNC = { bg = "none" },
						NeoTreeEndOfBuffer = { bg = "none" },
						SnacksDashboardNormal = { bg = "none" },
						-- SnacksDashboardTerminal = { bg = "none" },
						NoiceArrowLavender = {
							fg = colors.lavender,
							bold = true,
							bg = "none",
						},
						NoiceBracketBlue = {
							fg = colors.blue,
							bold = true,
						},


					}
				end,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
